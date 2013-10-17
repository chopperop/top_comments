require 'rubygems'
require 'snoo'

class PagesController < ApplicationController
  def home
    # if Comment.all.count == 0
    #    Comment.create(:name => "clicks")
    # end
    
    @clicks = Comment.first
    
    # @subreddits = Rails.cache.fetch('subreddits') do 
#       ['all', 'drugs', 'AskReddit', 'IAmA', 'bestof', 'pettyrevenge', 'DoesAnybodyElse', 'WTF', 'aww', 'cringepics',  'JusticePorn', 'creepyPMs', 'gaming', 'Games', 'movies', 'funny', 'AdviceAnimals', 'pics', 'videos', 'gifs', 'todayilearned', 'science', 'askscience', 'YouShouldKnow', 'explainlikeimfive', 'trees', 'LifeProTips', 'sex', 'Fitness', 'lifehacks', 'politics', 'worldnews', 'news', 'TrueReddit', 'technology', 'Android', 'programming', 'apple', 'dmt']
#     end
    @subreddits = ['drugs']
    @subRand = @subreddits.sample
    #test
    reddit = Snoo::Client.new do |con|
      con.adapter :em_http
    end
    
    parent = Rails.cache.fetch("parent_#{@subRand}", expires_in: 2.hours) do
      reddit.get_listing(subreddit: @subRand, sort: 'hot', limit: 25)["data"]["children"]
    end
    
    comment = Rails.cache.fetch("comment_#{@subRand}", expires_in: 2.hours) do 
      commentsArray = []
      parent.each do |a|
        id = a["data"]["id"]
        commentsArray.push(reddit.get_comments(link_id: id, sort: "best", limit: 1)[1]["data"]["children"])
      end
      commentsArray
    end
    
    Rails.cache.delete("parent_#{@subRand}")
    Rails.cache.delete("comment_#{@subRand}")
    
    rand = rand(0..24)
    @parentLink = parent[rand]["data"]
    @firstParentComment = comment[rand][0]["data"]
    
    @title = @parentLink["title"]
    @numComments = @parentLink["num_comments"]
    @url = @parentLink["permalink"]
    if !@parentLink["url"].include?("reddit")
      @externalLink = @parentLink["url"]
    else
      @externalLink = nil
    end

    if !@firstParentComment.empty?
      @parentComment = @firstParentComment
      @author = @parentComment["author"]
      @comment = @parentComment["body"]
      @points = @parentComment["ups"]
      @time = DateTime.strptime(@parentComment["created_utc"].to_s, '%s').to_s
    
      @clicks.update_attribute(:score, @clicks.score += 1)
    end
  
  end

  def about
  end

  def contact
  end
end
