require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'

class PagesController < ApplicationController
  def home
    agent = Mechanize.new

    page = agent.get('http://reddit.com/')
    
    #page = Nokogiri::HTML(open('http://reddit.com/'))
    @page = page
    @titles = page.search("#siteTable a.title")
    @titlesArray = @titles.to_a
    @titlesIntArray = (0..(@titles.to_a.count-1)).to_a
    @randomArray = @titlesIntArray.shuffle
    random = rand(@titles.to_a.count)
    @comments = page.search("#siteTable a.comments")
    @commentsArray = @comments.to_a
    #@links = page.links
  end

  def about
  end

  def contact
  end
end
