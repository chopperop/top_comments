require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'snoo'
require 'httparty'
require 'curb'
require 'json'
require 'httpclient'

class PagesController < ApplicationController
  def home
    # if Comment.all.count == 0
#       Comment.create(:name => "clicks")
#     end
  
  @clicks = Comment.first
  
  httpc = HTTPClient.new
  resp = httpc.head('http://www.reddit.com/r/random/random', :follow_redirect => true)
  @reddit =  resp.header.request_uri
  @parentLink = JSON.parse(httpc.get_content(@reddit + '.json'))[0]["data"]["children"][0]["data"]
  
  #@title, @subreddit, @numComments, @url, @externalLink, @author, @comment, @points, @time, @subRand = Array.new(10){[]}
  
  # for i in 0..0
  @parentLink.each do |parent|
    if parent[0] == "title"
      @title = parent[1]
    elsif parent[0] == "subreddit"
      @subreddit = parent[1]
    elsif parent[0] == "num_comments"
      @numComments = parent[1]
    elsif parent[0] == "url"
      @url = parent[1]
    elsif parent[0] == "permalink"
      if !parent[1].include?("reddit")
        @externalLink = parent[1]
      else
        @externalLink = nil
      end
    end
  end
  # end
    
  end

  def about
  end

  def contact
  end
end
