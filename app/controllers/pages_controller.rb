require 'rubygems'
require 'snoo'

class PagesController < ApplicationController
  def home
    # if Comment.all.count == 0
#       Comment.create(:name => "clicks")
#     end
    
    @clicks = Comment.first
    
    @subreddits = ['all', 'drugs', 'AskReddit', 'IAmA', 'bestof', 'pettyrevenge', 'DoesAnybodyElse', 'WTF', 'aww', 'cringepics',  'JusticePorn', 'creepyPMs', 'gaming', 'Games', 'movies', 'funny', 'AdviceAnimals', 'pics', 'videos', 'gifs', 'todayilearned', 'science', 'askscience', 'YouShouldKnow', 'explainlikeimfive', 'trees', 'LifeProTips', 'sex', 'Fitness', 'lifehacks', 'politics', 'worldnews', 'news', 'TrueReddit', 'technology', 'Android', 'programming', 'apple', 'dmt']

    @subRand = @subreddits.shuffle.first
    
    def reddit
      
      reddit = Snoo::Client.new do |con|
        con.adapter :em_http
      end
    
      rand = rand(0..4)
      parent = reddit.get_listing(subreddit: @subRand, sort: 'hot', limit: 5)["data"]["children"][rand]["data"]
      
      title = parent["title"]
      numComments = parent["num_comments"]
      url = parent["permalink"]
      if !parent["url"].include?("reddit")
        externalLink = parent["url"]
      else
        externalLink = nil
      end
      
      @link_id = parent["id"]
      
      comment = reddit.get_comments(link_id: @link_id, sort: "best", limit: 1)[1]["data"]["children"]
        
      return title, numComments, url, externalLink, comment
    end
    
    @title, @numComments, @url, @externalLink, @firstParentComment = reddit

    if !@firstParentComment.empty?
      @parentComment = @firstParentComment[0]["data"]
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
