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
    subreddits = ['all', 'drugs']
    
    
    
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
      
        
        @clicks.score += 1
        @clicks.save
        
    
    
  end

  def about
  end

  def contact
  end
end
