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
    subreddits = ['all']
  
    @title, @numComments, @url, @externalLink, @author, @comment, @points, @time, @subRand = Array.new(9){[]}
    
    for i in 0..0
      #@subRand[i] = @subreddits.sample.subreddit
      #@subRand[i] = @subreddit
      @subRand[i] = subreddits.sample
    
      rand = rand(0..4)
      @parentLink = reddit.get_listing(subreddit: @subRand[i], sort: 'hot', limit: 5)["data"]["children"][rand]["data"]
      @title[i] = @parentLink["title"]
      @numComments[i] = @parentLink["num_comments"]
      @url[i] = @parentLink["permalink"]
      if !@parentLink["url"].include?("reddit")
        @externalLink[i] = @parentLink["url"]
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
