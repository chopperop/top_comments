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
       
    #subreddits = ['all', 'drugs', 'AskReddit', 'IAmA', 'pettyrevenge', 'DoesAnybodyElse', 'WTF', 'aww', 'JusticePorn', 'creepyPMs', 'funny', 'AdviceAnimals', 'pics', 'videos', 'gifs', 'todayilearned', 'science', 'YouShouldKnow', 'explainlikeimfive', 'LifeProTips', 'sex', 'Fitness', 'lifehacks', 'worldnews', 'news', 'technology', 'dmt']
    
    
    @title, @numComments, @url, @externalLink, @author, @comment, @points, @time, @subRand = Array.new(9){[]}
    
    for i in 0..0
      #@subRand[i] = subreddits[subredditsRand]
      subredditsRand = rand(0..5)
      case subredditsRand
      when 0 
        @subRand[i] = 'all' #all and random
      when 1 
        @subRand[i] = 'drugs'
      when 2 
        @subRand[i] = 'AskReddit'
      when 3 
        @subRand[i] = 'IAmA'
      when 4 
        @subRand[i] = 'pettyrevenge'
      when 5 
        @subRand[i] = 'DoesAnybodyElse'  
      end  
    
      rand = rand(0..4)
      @parentLink = reddit.get_listing(subreddit: @subRand[i], limit: 5, sort: 'hot')["data"]["children"][rand]["data"]
      @title[i] = @parentLink["title"]
      @numComments[i] = @parentLink["num_comments"]
      @url[i] = @parentLink["permalink"]
      if !@parentLink["url"].include?("reddit")
        @externalLink[i] = @parentLink["url"]
      end
      @link_id = @parentLink["id"]
    
    
      @firstParentComment = reddit.get_comments(link_id: @link_id, sort: "best", limit: 2)[1]["data"]["children"]
    
      if !@firstParentComment.empty?
        if @firstParentComment.length == 2
          rand2 = rand(0..1)
        else
          rand2 = 0
        end
        @parentComment = @firstParentComment[rand2]["data"]
        @author[i] = @parentComment["author"]
        @comment[i] = @parentComment["body"]
        @points[i] = @parentComment["ups"]
        @time[i] = DateTime.strptime(@parentComment["created_utc"].to_s, '%s').to_s
        
        @clicks.score += 1
        @clicks.save
      end
    end
    
  end

  def about
  end

  def contact
  end
end
