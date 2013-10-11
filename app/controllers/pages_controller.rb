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
    
    def reddit
      
      reddit = Snoo::Client.new do |con|
        con.adapter :em_http
      end
    
      #@subreddits = Reddit.all   
      #@subreddit = Reddit.all.sample.subreddit   
      subreddits = ['all', 'drugs']
    
      #@title, @numComments, @url, @externalLink, @author, @comment, @points, @time, @subRand = Array.new(9){[]}
    
    
      #@subRand = @subreddits.sample.subreddit
      #@subRand = @subreddit
      @subRand = subreddits.shuffle.first
  
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
