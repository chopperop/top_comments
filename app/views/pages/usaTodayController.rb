require 'rubygems'
require 'snoo'
require 'httparty'

class PagesController < ApplicationController
  def home
    @clicks = Comment.first
    
    api = 'tu3wfb83x3hb8s9asc8ugc35'
    usatoday = HTTParty.get("http://api.usatoday.com/open/articles/topnews?encoding=json&api_key=#{api}") 
    @usa = usatoday["stories"][0]["link"]
    @story = HTTParty.get(@usa)
  end

  def about
  end

  def contact
  end
end