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
    
    @subreddits = ['all', 'drugs', 'AskReddit', 'IAmA', 'bestof', 'pettyrevenge', 'DoesAnybodyElse', 'WTF', 'aww', 'cringepics',  'JusticePorn', 'creepyPMs', 'gaming', 'Games', 'movies', 'funny', 'AdviceAnimals', 'pics', 'videos', 'gifs', 'todayilearned', 'science', 'askscience', 'YouShouldKnow', 'explainlikeimfive', 'trees', 'LifeProTips', 'sex', 'Fitness', 'lifehacks', 'politics', 'worldnews', 'news', 'TrueReddit', 'technology', 'Android', 'programming', 'apple', 'dmt']
    randReddit = rand(0..38)
    @subRand = @subreddits[randReddit]
    
    def reddit
      
      reddit = Snoo::Client.new do |con|
        con.adapter :em_http
      end
    
      
  
      rand = rand(0..4)
      parent = reddit.get_listing(subreddit: @subRand, sort: 'hot', limit: 5)["data"]["children"][rand]["data"]
      
      @link_id = parent["id"]
      
      comment = reddit.get_comments(link_id: @link_id, sort: "best", limit: 2)[1]["data"]["children"]
        
      return parent, comment
    end
    
    @parentLink, @firstParentComment = reddit
    
    @title = @parentLink["title"]
    @numComments = @parentLink["num_comments"]
    @url = @parentLink["permalink"]
    if !@parentLink["url"].include?("reddit")
      @externalLink = @parentLink["url"]
    else
      @externalLink = nil
    end

    if !@firstParentComment.empty?
      if @firstParentComment.length >= 2
        rand2 = rand(0..(@firstParentComment.length-2))
      else
        rand2 = 0
      end
      @parentComment = @firstParentComment[rand2]["data"]
      @author = @parentComment["author"]
      @comment = @parentComment["body"]
      @points = @parentComment["ups"]
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
