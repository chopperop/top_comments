require 'rubygems'
require 'snoo'

class PagesController < ApplicationController
  def home
    # if Comment.all.count == 0
    #    Comment.create(:name => "clicks")
    # end
    
    @clicks = Comment.first
    
    @subreddits = Rails.cache.fetch('subreddits') do 
      ['all', 'drugs', 'AskReddit', 'IAmA', 'bestof', 'pettyrevenge', 'DoesAnybodyElse', 'WTF', 'aww', 'cringepics',  'JusticePorn', 'creepyPMs', 'gaming', 'Games', 'movies', 'funny', 'AdviceAnimals', 'pics', 'videos', 'gifs', 'todayilearned', 'science', 'askscience', 'YouShouldKnow', 'explainlikeimfive', 'trees', 'LifeProTips', 'sex', 'Fitness', 'lifehacks', 'politics', 'worldnews', 'news', 'TrueReddit', 'technology', 'Android', 'programming', 'apple', 'dmt']
    end
    #@subreddits = ['drugs']
    @subRand = @subreddits.sample
    
    reddit = Snoo::Client.new do |con|
      con.adapter :em_http
    end
    
    if Rails.cache.read("parent1_#{@subRand}").nil?
      parent = Rails.cache.fetch("parent2_#{@subRand}", expires_in: 2.hours) do
        reddit.get_listing(subreddit: @subRand, sort: 'hot', limit: 2)["data"]["children"]
      end
    
      comment = Rails.cache.fetch("comment2_#{@subRand}", expires_in: 2.hours) do 
        commentsArray = []
        parent.each do |a|
          id = a["data"]["id"]
          commentsArray.push(reddit.get_comments(link_id: id, sort: "best", limit: 1)[1]["data"]["children"])
        end
        commentsArray
      end
      if Rails.cache.read("parent1").nil?
        Rails.cache.fetch("parent1", expires_in: 1.hour) { "sending parent1 job" }
        RedditWorker.perform_in(1.hour, @subRand)
      end
    else 
      parent = Rails.cache.fetch("parent2_#{@subRand}", expires_in: 2.hours) do
        reddit.get_listing(subreddit: @subRand, sort: 'hot', limit: 2)["data"]["children"]
      end
    
      comment = Rails.cache.fetch("comment2_#{@subRand}", expires_in: 2.hours) do 
        commentsArray = []
        parent.each do |a|
          id = a["data"]["id"]
          commentsArray.push(reddit.get_comments(link_id: id, sort: "best", limit: 1)[1]["data"]["children"])
        end
        commentsArray
      end
      if Rails.cache.read("parent2").nil?
        Rails.cache.fetch("parent2", expires_in: 1.hour) { "sending parent2 job" }
        RedditWorker.perform_in(1.hour, @subRand)
      end
    end
    
    # Rails.cache.delete("parent_#{@subRand}")
#     Rails.cache.delete("comment_#{@subRand}")
#     Rails.cache.delete("parent1_#{@subRand}")
#     Rails.cache.delete("comment1_#{@subRand}")
#     Rails.cache.delete("parent1")
#     Rails.cache.delete("parent2_#{@subRand}")
#     Rails.cache.delete("comment2_#{@subRand}")
#     Rails.cache.delete("parent2")
    
    rand = rand(0..1)
    @parentLink = parent[rand]["data"]
    @firstParentComment = comment[rand]
    
    @title = @parentLink["title"]
    @numComments = @parentLink["num_comments"]
    @url = @parentLink["permalink"]
    if !@parentLink["url"].include?("reddit")
      @externalLink = @parentLink["url"]
    else
      @externalLink = nil
    end

    if !@firstParentComment.empty?
      @parentComment = @firstParentComment[0]["data"]
      @author = @parentComment["author"]
      @comment = @parentComment["body"]
      @points = @parentComment["ups"]
      @time = DateTime.strptime(@parentComment["created_utc"].to_s, '%s').to_s
    
      @clicks.update_attribute(:score, @clicks.score += 1)
    end
  
  end

  def about
  end

  def contact
  end
end
