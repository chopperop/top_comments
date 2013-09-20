require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'snoo'

class PagesController < ApplicationController
  def home
    reddit = Snoo::Client.new
    
    @subreddits = Reddit.all   
    @subRand = @subreddits.sample.subreddit
    
    rand = rand(0..24)
    @parentLink = reddit.get_listing(subreddit: @subRand, sort: 'hot')["data"]["children"][rand]["data"]
    @title = @parentLink["title"]
    @numComments = @parentLink["num_comments"]
    @url = @parentLink["permalink"]
    @link_id = @parentLink["id"]
    
    
    @firstParentComment = reddit.get_comments(link_id: @link_id, sort: "best", limit: 5)[1]["data"]["children"]
    
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
    end
    
  end

  def about
  end

  def contact
  end
end
