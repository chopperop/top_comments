require 'snoo'

class RedditWorker
  include Sidekiq::Worker
  
  def perform(subreddit)
    reddit = Snoo::Client.new do |con|
      con.adapter :em_http
    end
    
    sub = subreddit
    
    parent = reddit.get_listing(subreddit: sub, sort: 'hot', limit: 7)["data"]["children"]
    Rails.cache.write("parent_#{sub}", parent) 
    
    commentsArray = []
    parent.each do |a|
      id = a["data"]["id"]
      commentsArray.push(reddit.get_comments(link_id: id, sort: "best", limit: 1)[1]["data"]["children"])
    end
    Rails.cache.write("comment_#{sub}", commentsArray)
    # Rails.cache.fetch("expire_#{sub}", expires_in: 30.minutes) { "wait period" }
  end
end