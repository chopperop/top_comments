require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'snoo'

class PagesController < ApplicationController
  def home
    reddit = Snoo::Client.new
    @homeLinks = reddit.get_listing["data"]["children"]
    homeRand = rand(0..24)
    @home = reddit.get_listing["data"]["children"][homeRand]["data"]["id"]
    @link = reddit.get_listing["data"]["children"][homeRand]["data"]["permalink"]
    @title = reddit.get_listing["data"]["children"][homeRand]["data"]["title"]
    #@links = reddit.get_comments(:link_id => reddit.get_listing[10], :limit => 1)["data"]["children"][0]["data"]["link_title"]
    rand = rand(0..4)
    @comments = reddit.get_comments(link_id: @home, sort: "best")[1]["data"]["children"][rand]["data"]["body"]
    #@comment = reddit.get_comments(link_id: @home, comment_id: "t3_")
  end

  def about
  end

  def contact
  end
end