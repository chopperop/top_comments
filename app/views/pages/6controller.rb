require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'snoo'

class PagesController < ApplicationController
  def home
    reddit = Snoo::Client.new
 
    @subreddits = ['all', 'drugs', 'AskReddit', 'IAmA', 'bestof', 'fatpeoplestories', 'pettyrevenge', 'TalesFromRetail', 'DoesAnybodyElse', 'CrazyIdeas', 'WTF', 'aww', 'cringepics', 'cringe', 'JusticePorn', 'MorbidReality', 'rage', 'mildlyinfuriating', 'creepy', 'creepyPMs', 'nosleep', 'nostalgia', 'gaming', 'leagueoflegends', 'pokemon', 'Minecraft', 'starcraft', 'Games', 'DotA2', 'wow', 'battlefield3', 'zelda', 'arresteddevelopment', 'gameofthrones', 'doctorwho', 'community', 'breakingbad', 'TheSimpsons', 'futurama', 'HIMYM', 'Music', 'movies', 'harrypotter', 'StarWars', 'hiphopheads', 'anime', 'comicbooks', 'geek', 'batman', 'TheLastAirbender', 'Naruto', 'funny', 'AdviceAnimals', 'fffffffuuuuuuuuuuuu', '4chan', 'ImGoingToHellForThis', 'circlejerk', 'MURICA', 'facepalm', 'Jokes', 'wheredidthesodago', 'comics', 'nottheonion', 'pics', 'videos', 'gifs', 'reactiongifs', 'mildlyinteresting','woahdude', 'FoodPorn', 'HistoryPorn', 'wallpapers', 'youtubehaiku', 'photoshopbattles', 'AnimalsBeingJerks', 'cosplay', 'EarthPorn', 'QuotesPorn', 'AbandonedPorn', 'PerfectTiming', 'carporn', 'RoomPorn', 'itookapicture', 'todayilearned', 'science', 'askscience', 'space', 'AskHistorians', 'YouShouldKnow', 'explainlikeimfive', 'trees', 'MakeupAddiction', 'cats', 'LifeProTips', 'RedditLaqueristas', 'food', 'guns', 'tattoos', 'GetMotivated', 'sex', 'DIY', 'Fitness', 'lifehacks', 'Frugal', 'Art', 'loseit', 'politics', 'worldnews', 'news', 'conspiracy', 'TrueReddit', 'offbeat', 'canada', 'atheism', 'TwoXChromosomes', 'lgbt', 'nba', 'soccer', 'hockey', 'nfl', 'baseball', 'MMA', 'technology', 'Android', 'programming', 'apple', 'dmt', 'ZenHabits', 'dmt']
    @subRand = @subreddits[2]  #@subreddit[rand(@subreddit.length)]
    
    #@parent = reddit.get_comments(subreddit: @subRand, sort: 'hot')["data"]["children"][rand]["data"]
    @parentArray = reddit.get_comments(subreddit: @subRand, sort: 'hot')["data"]["children"].find_all{|s| s["data"]["parent_id"] =~ /t3_/}
    @parent = @parentArray.sample["data"]
    @title = @parent["link_title"] 
    @comment = @parent["body"]
    @link_id = @parent["link_id"]
    @link = reddit.get_listing(subreddit: @subRand, sort: 'hot')["data"]["children"].find{|s| s["data"]["name"] == @link_id}
    #@title = @link["data"]["title"] if @link
    if @link
      @url = @link["data"]["permalink"] 
    else 
      @url = '/r/' + @subRand
    end
  end

  def about
  end

  def contact
  end
end
