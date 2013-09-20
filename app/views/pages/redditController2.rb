require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'snoo'

class PagesController < ApplicationController
  def home
    reddit = Snoo::Client.new
    
    rand = rand(0..4)
    @comments = reddit.get_comments(subreddit: 'drugs')["data"]["children"][rand]["data"]["body"]
  end

  def about
  end

  def contact
  end
end
