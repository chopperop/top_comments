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
    @titlesIntArray = (0..(@titles.to_a.count-1)).to_a
    
    @randContainer = []
    @titleContainer = []
    @commentContainer = []
    @commentLinkContainer = []
    @pageContainer = []
    @parentContainer = []
    @taglineContainer = []
    @authorContainer = []
    @pointsContainer = []
    @timeContainer = []
    @clickCommentContainer = []
    @clickPContainer = []
    
    for i in 0..1
      @rand = rand(0..(@titles.count-1))
      if @randContainer.include?(@rand) 
        @rand = rand(0..(@titles.count-1))
        @randContainer.push(@rand)
      else
        @randContainer.push(@rand)
      end
    end
    
    @comments = page.search("#siteTable a.comments")
    
    for i in 0..(@randContainer.count-1)
      @titleContainer[i] = @titles[@randContainer[i]]
      @commentContainer[i] = @comments[@randContainer[i]]
      @commentLinkContainer[i] = @commentContainer[i][:href]
      @pageContainer[i] = agent.get(@commentLinkContainer[i])
      @parentContainer[i] = @pageContainer[i].search(".sitetable.nestedlisting")
      
      @taglineContainer[i] = @parentContainer[i].css(".tagline")[0]
      
      @authorContainer[i] = @taglineContainer[i].css("a.author")[0]
      @pointsContainer[i] = @taglineContainer[i].css("span.score.unvoted")[0] 
      @timeContainer[i] = @taglineContainer[i].css("time")[0]
      @clickCommentContainer[i] = @parentContainer[i].css(".md")[0]
      @clickPContainer[i] = @clickCommentContainer[i].css("p")
    end
     
  end

  def about
  end

  def contact
  end
end
