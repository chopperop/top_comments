require 'snoo'

class RedditWorker
  include Sidekiq::Worker
  
  def perform(subreddit)
    reddit = Snoo::Client.new do |con|
      con.adapter :em_http
    end
    
    sub = subreddit
    
    if Rails.cache.read("parent1_#{sub}").nil?
      Rails.cache.fetch("parent1_#{sub}", expires_in: 1.hour) do
        reddit.get_listing(subreddit: @subRand, sort: 'hot', limit: 10)["data"]["children"]
      end
    
      Rails.cache.fetch("comment1_#{sub}", expires_in: 1.hour) do 
        commentsArray = []
        parent.each do |a|
          id = a["data"]["id"]
          commentsArray.push(reddit.get_comments(link_id: id, sort: "best", limit: 1)[1]["data"]["children"])
        end
        commentsArray
      end
      if Rails.cache.read("parent1").nil?
        Rails.cache.fetch("parent1", expires_in: 30.minutes) { "sending parent1 job" }
        perform_in(30.minutes, sub)
      end
    else 
      Rails.cache.fetch("parent2_#{sub}", expires_in: 1.hour) do
        reddit.get_listing(subreddit: @subRand, sort: 'hot', limit: 10)["data"]["children"]
      end
    
      Rails.cache.fetch("comment2_#{sub}", expires_in: 1.hour) do 
        commentsArray = []
        parent.each do |a|
          id = a["data"]["id"]
          commentsArray.push(reddit.get_comments(link_id: id, sort: "best", limit: 1)[1]["data"]["children"])
        end
        commentsArray
      end
      if Rails.cache.read("parent2").nil?
        Rails.cache.fetch("parent2", expires_in: 30.minutes) { "sending parent2 job" }
        perform_in(30.minutes, sub)
      end
    end
    
  end
end