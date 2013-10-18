require 'rubygems'
require 'snoo'

class PagesController < ApplicationController
  def home
    # if Comment.all.count == 0
    #    Comment.create(:name => "clicks")
    # end
    
    @clicks = Comment.first
    
    @subreddits = Rails.cache.fetch('subreddits') do 
      ['all', 'drugs', 'AskReddit', 'IAmA', 'bestof', 'fatpeoplestories', 'pettyrevenge', 'TalesFromRetail', 'DoesAnybodyElse', 'CrazyIdeas', 'WTF', 'aww', 'cringepics', 'cringe', 'JusticePorn', 'MorbidReality', 'rage', 'mildlyinfuriating', 'creepy', 'creepyPMs', 'nosleep', 'nostalgia', 'gaming', 'leagueoflegends', 'pokemon', 'Minecraft', 'starcraft', 'Games', 'DotA2', 'wow', 'battlefield3', 'zelda', 'arresteddevelopment', 'gameofthrones', 'doctorwho', 'community', 'breakingbad', 'TheSimpsons', 'futurama', 'HIMYM', 'Music', 'movies', 'harrypotter', 'StarWars', 'hiphopheads', 'anime', 'comicbooks', 'geek', 'batman', 'TheLastAirbender', 'Naruto', 'funny', 'AdviceAnimals', 'fffffffuuuuuuuuuuuu', '4chan', 'ImGoingToHellForThis', 'circlejerk', 'MURICA', 'facepalm', 'Jokes', 'wheredidthesodago', 'comics', 'nottheonion', 'pics', 'videos', 'gifs', 'reactiongifs', 'mildlyinteresting','woahdude', 'FoodPorn', 'HistoryPorn', 'wallpapers', 'youtubehaiku', 'photoshopbattles', 'AnimalsBeingJerks', 'cosplay', 'EarthPorn', 'QuotesPorn', 'AbandonedPorn', 'PerfectTiming', 'carporn', 'RoomPorn', 'itookapicture', 'todayilearned', 'science', 'askscience', 'space', 'AskHistorians', 'YouShouldKnow', 'explainlikeimfive', 'trees', 'MakeupAddiction', 'cats', 'LifeProTips', 'RedditLaqueristas', 'food', 'guns', 'tattoos', 'GetMotivated', 'sex', 'DIY', 'Fitness', 'lifehacks', 'Frugal', 'Art', 'loseit', 'politics', 'worldnews', 'news', 'conspiracy', 'TrueReddit', 'offbeat', 'canada', 'atheism', 'TwoXChromosomes', 'lgbt', 'nba', 'soccer', 'hockey', 'nfl', 'baseball', 'MMA', 'technology', 'Android', 'programming', 'apple', 'dmt', 'ZenHabits', 'dmt']
    end
    #@subreddits = ['drugs']
    @subRand = @subreddits.sample
    
    reddit = Snoo::Client.new do |con|
      con.adapter :em_http
    end
    
    if Rails.cache.read("parent1_#{@subRand}").nil?
      parent = Rails.cache.fetch("parent2_#{@subRand}", expires_in: 1.hour) do
        reddit.get_listing(subreddit: @subRand, sort: 'hot', limit: 7)["data"]["children"]
      end
    
      comment = Rails.cache.fetch("comment2_#{@subRand}", expires_in: 1.hour) do 
        commentsArray = []
        parent.each do |a|
          id = a["data"]["id"]
          commentsArray.push(reddit.get_comments(link_id: id, sort: "best", limit: 1)[1]["data"]["children"])
        end
        commentsArray
      end
      if Rails.cache.read("parent1").nil?
        Rails.cache.fetch("parent1", expires_in: 30.minutes) { "sending parent1 job" }
        RedditWorker.perform_in(30.minutes, @subRand)
      end
    else 
      parent = Rails.cache.fetch("parent2_#{@subRand}", expires_in: 1.hour) do
        reddit.get_listing(subreddit: @subRand, sort: 'hot', limit: 7)["data"]["children"]
      end
    
      comment = Rails.cache.fetch("comment2_#{@subRand}", expires_in: 1.hour) do 
        commentsArray = []
        parent.each do |a|
          id = a["data"]["id"]
          commentsArray.push(reddit.get_comments(link_id: id, sort: "best", limit: 1)[1]["data"]["children"])
        end
        commentsArray
      end
      if Rails.cache.read("parent2").nil?
        Rails.cache.fetch("parent2", expires_in: 30.minutes) { "sending parent2 job" }
        RedditWorker.perform_in(30.minutes, @subRand)
      end
    end
    
    if Rails.cache.read("parent1_#{@subRand}").nil?
      parent = Rails.cache.fetch("parent2_#{@subRand}", expires_in: 1.hour) do
        reddit.get_listing(subreddit: @subRand, sort: 'hot', limit: 7)["data"]["children"]
      end
    
      comment = Rails.cache.fetch("comment2_#{@subRand}", expires_in: 1.hour) do 
        commentsArray = []
        parent.each do |a|
          id = a["data"]["id"]
          commentsArray.push(reddit.get_comments(link_id: id, sort: "best", limit: 1)[1]["data"]["children"])
        end
        commentsArray
      end
      if Rails.cache.read("parent1").nil?
        Rails.cache.fetch("parent1", expires_in: 30.minutes) { "sending parent1 job" }
        RedditWorker.perform_in(30.minutes, @subRand)
      end
    else 
      parent = Rails.cache.fetch("parent2_#{@subRand}", expires_in: 1.hour) do
        reddit.get_listing(subreddit: @subRand, sort: 'hot', limit: 7)["data"]["children"]
      end
    
      comment = Rails.cache.fetch("comment2_#{@subRand}", expires_in: 1.hour) do 
        commentsArray = []
        parent.each do |a|
          id = a["data"]["id"]
          commentsArray.push(reddit.get_comments(link_id: id, sort: "best", limit: 1)[1]["data"]["children"])
        end
        commentsArray
      end
      if Rails.cache.read("parent2").nil?
        Rails.cache.fetch("parent2", expires_in: 30.minutes) { "sending parent2 job" }
        RedditWorker.perform_in(30.minutes, @subRand)
      end
    end
    
    # Rails.cache.delete("parent_#{@subRand}")
#     Rails.cache.delete("comment_#{@subRand}")
#     Rails.cache.delete("parent1_#{@subRand}")
#     Rails.cache.delete("comment1_#{@subRand}")
#     Rails.cache.delete("parent1")
#     Rails.cache.delete("parent2_#{@subRand}")
#     Rails.cache.delete("comment2_#{@subRand}")
#     Rails.cache.delete("parent2")
    
    rand = rand(0..6)
    @parentLink = parent[rand]["data"]
    @firstParentComment = comment[rand]
    
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
