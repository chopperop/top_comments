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
       
    subreddits = ['all', 'drugs', 'AskReddit', 'IAmA', 'bestof', 'pettyrevenge', 'DoesAnybodyElse', 'WTF', 'aww', 'cringepics',  'JusticePorn', 'creepyPMs', 'gaming', 'Games', 'movies', 'funny', 'AdviceAnimals', 'pics', 'videos', 'gifs', 'todayilearned', 'science', 'askscience', 'YouShouldKnow', 'explainlikeimfive', 'trees', 'LifeProTips', 'sex', 'Fitness', 'lifehacks', 'politics', 'worldnews', 'news', 'TrueReddit', 'technology', 'Android', 'programming', 'apple', 'dmt']
    subredditsRand = rand(0..39)
    @title, @numComments, @url, @externalLink, @author, @comment, @points, @time, @subRand = Array.new(9){[]}
    
    for i in 0..0
      @subRand[i] = subreddits[subredditsRand]
    
      rand = rand(0..24)
      @parentLink = reddit.get_listing(subreddit: @subRand[i], sort: 'hot')["data"]["children"][rand]["data"]
      @title[i] = @parentLink["title"]
      @numComments[i] = @parentLink["num_comments"]
      @url[i] = @parentLink["permalink"]
      if !@parentLink["url"].include?("reddit")
        @externalLink[i] = @parentLink["url"]
      end
      @link_id = @parentLink["id"]
    
    
      # @firstParentComment = reddit.get_comments(link_id: @link_id, sort: "best", limit: 5)[1]["data"]["children"]
#     
#       if !@firstParentComment.empty?
#         if @firstParentComment.length >= 2
#           rand2 = rand(0..(@firstParentComment.length-2))
#         else
#           rand2 = 0
#         end
#         @parentComment = @firstParentComment[rand2]["data"]
#         @author[i] = @parentComment["author"]
#         @comment[i] = @parentComment["body"]
#         @points[i] = @parentComment["ups"]
#         @time[i] = DateTime.strptime(@parentComment["created_utc"].to_s, '%s').to_s
#         
#         @clicks.score += 1
#         @clicks.save
#       end
    end
    
  end

  def about
  end

  def contact
  end
end
