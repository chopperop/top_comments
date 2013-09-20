require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'

class PagesController < ApplicationController
  def home
    agent = Mechanize.new

    agent.get('http://reddit.com/') do |home|
      @homeLink = home.search("#siteTable a.comments")
      
      rand1 = rand(0..(@homeLink.count-1))
      @link = @homeLink[rand1][:href]
      
      second = agent.get(@link)
      
      @title = second.search("a.title")
      @parent = second.search(".sitetable.nestedlisting")
      @tagline = @parent.css(".tagline")[0]
      @author = @tagline.css("a.author")[0]
      @points = @tagline.css("span.score.unvoted")[0]
      @time = @tagline.css("time")[0]
      @comment = @parent.css(".md")[0].css("p")
    end
     
  end

  def about
  end

  def contact
  end
end
