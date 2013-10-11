require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'snoo'

class PagesController < ApplicationController
  def home
    # if Comment.all.count == 0
#       Comment.create(:name => "clicks")
#     end
    
    @clicks = Comment.first
    
    reddit = Snoo::Client.new do |con|
      con.adapter :em_http
    end
    
    #@subreddits = Reddit.all   
    #@subreddit = Reddit.all.sample.subreddit   
    subreddits = ['all', 'drugs', 'AskReddit', 'IAmA', 'bestof', 'pettyrevenge', 'DoesAnybodyElse', 'WTF', 'aww', 'cringepics',  'JusticePorn', 'creepyPMs', 'gaming', 'Games', 'movies', 'funny', 'AdviceAnimals', 'pics', 'videos', 'gifs', 'todayilearned', 'science', 'askscience', 'YouShouldKnow', 'explainlikeimfive', 'trees', 'LifeProTips', 'sex', 'Fitness', 'lifehacks', 'politics', 'worldnews', 'news', 'TrueReddit', 'technology', 'Android', 'programming', 'apple', 'dmt']
  
    
    
    
      #@subRand = @subreddits.sample.subreddit
      #@subRand = @subreddit
      @subRand = subreddits.shuffle.first
    
      rand = rand(0..4)
      @parentLink = reddit.get_listing(subreddit: @subRand, sort: 'hot', limit: 5)["data"]["children"][rand]["data"]
      
      if !@parentLink["url"].include?("reddit")
        @externalLink = @parentLink["url"]
      else
        @externalLink = nil
      end
      @link_id = @parentLink["id"]
    
    
      @firstParentComment = reddit.get_comments(link_id: @link_id, sort: "best", limit: 2)[1]["data"]["children"]
    
      if !@firstParentComment.empty?
        if @firstParentComment.length >= 2
          rand2 = rand(0..(@firstParentComment.length-2))
        else
          rand2 = 0
        end
        @parentComment = @firstParentComment[rand2]["data"]
        
        @time = DateTime.strptime(@parentComment["created_utc"].to_s, '%s').to_s
        
        @clicks.score += 1
        @clicks.save
      end
    
    
  end

  def about
  end

  def contact
  end
end
