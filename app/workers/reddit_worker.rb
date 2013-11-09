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
    
    x = 0
    
    commentsArray.each do |com|
      if !com.empty?
        parentPar = parent[x]["data"]
        title = parentPar["title"]
        numComments = parentPar["num_comments"]
        url = parentPar["permalink"]
        if !parentPar["url"].include?("reddit")
          externalLink = parentPar["url"]
        else
          externalLink = nil
        end
        
        parentCom = com[0]["data"]
        author = parentCom["author"]
        body = parentCom["body"]
        points = parentCom["ups"]
        time = DateTime.strptime(parentCom["created_utc"].to_s, '%s').to_s
        if Reddit.find_by_comment(body).nil?
          reddit = Reddit.create(subreddit: subreddit, title: title, numComments: numComments, url: url, externalLink: externalLink, author: author, comment: body, points: points, time: time)
        end
      end
      x += 1
    end
    
    Reddit.where("created_at <= ?", 5.days.ago).delete_all
    
    # Rails.cache.fetch("expire_#{sub}", expires_in: 30.minutes) { "wait period" }
  end
end