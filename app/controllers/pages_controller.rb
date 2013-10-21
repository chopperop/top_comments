require 'rubygems'
require 'snoo'

class PagesController < ApplicationController
  def home
    # if Comment.all.count == 0
    #    Comment.create(:name => "clicks")
    # end
    
    @clicks = Comment.first
    
    @subreddits = Rails.cache.fetch('subreddits') do 
      ['all', 'drugs', 'AskReddit', 'IAmA', 'bestof', 'nba', 'soccer', 'hockey', 'nfl', 'baseball', 'MMA', 'Music', 'GetMotivated', 'LifeProTips', 'food', 'facepalm', 'Jokes', 'pettyrevenge', 'TalesFromRetail', 'DoesAnybodyElse', 'WTF', 'aww', 'cringe', 'cringepics',  'JusticePorn', 'creepyPMs', 'gaming', 'Games', 'movies', 'funny', 'AdviceAnimals', 'pics', 'videos', 'gifs', 'todayilearned', 'science', 'askscience', 'YouShouldKnow', 'explainlikeimfive', 'trees', 'LifeProTips', 'sex', 'Fitness', 'lifehacks', 'politics', 'worldnews', 'news', 'TrueReddit', 'technology', 'Android', 'programming', 'apple', 'dmt']
    end
    # @subreddits = ['wtf']
    @subRand = @subreddits.sample
    
    reddit = Snoo::Client.new do |con|
      con.adapter :em_http
    end
    
    if Rails.cache.read("parent_#{@subRand}").nil?
      parent = Rails.cache.fetch("parent_#{@subRand}") do 
        reddit.get_listing(subreddit: @subRand, sort: 'hot', limit: 1)["data"]["children"]
      end
      
      comment = Rails.cache.fetch("comment_#{@subRand}") do 
        commentsArray = []
        parent.each do |a|
          id = a["data"]["id"]
          commentsArray.push(reddit.get_comments(link_id: id, sort: "best", limit: 1)[1]["data"]["children"])
        end
        commentsArray
      end
      parentComment = nil
    else
      parentComment = Rails.cache.read_multi("parent_#{@subRand}", "comment_#{@subRand}")
    end
    
    # Rails.cache.delete('subreddits')
#     Rails.cache.delete("parent_#{@subRand}")
#     Rails.cache.delete("comment_#{@subRand}")
    
    rand = rand(0..0)
    if !parentComment.nil?
      @parentLink = parentComment["parent_#{@subRand}"][rand]["data"]
      @firstParentComment = parentComment["comment_#{@subRand}"][rand]
    else
      @parentLink = parent[rand]["data"]
      @firstParentComment = comment[rand]
    end
    
    @title = @parentLink["title"]
    @numComments = @parentLink["num_comments"]
    @url = @parentLink["permalink"]
    if !@parentLink["url"].include?("reddit")
      @externalLink = @parentLink["url"]
    else
      @externalLink = nil
    end

    if !@firstParentComment.empty?
      @parentComment = @firstParentComment[0]["data"]
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
