require 'rubygems'
require 'snoo'
require 'httparty'
require 'httpclient'
require 'youtube_it'
require 'nokogiri'
require 'open-uri'
require 'ruby-hackernews'
require 'mechanize'
#require 'quora-client'

class PagesController < ApplicationController
  def home
    # if Comment.all.count == 0
    #    Comment.create(:name => "clicks")
    # end
    
    @clicks = Comment.first
    
   #  @subreddits = Rails.cache.fetch('subreddits') do 
#       ['all', 'drugs', 'AskReddit', 'IAmA', 'bestof', 'nba', 'soccer', 'hockey', 'nfl', 'baseball', 'MMA', 'Music', 'GetMotivated', 'LifeProTips', 'food', 'facepalm', 'Jokes', 'pettyrevenge', 'TalesFromRetail', 'DoesAnybodyElse', 'WTF', 'aww', 'cringe', 'cringepics',  'JusticePorn', 'creepyPMs', 'gaming', 'Games', 'movies', 'funny', 'AdviceAnimals', 'pics', 'videos', 'gifs', 'todayilearned', 'science', 'askscience', 'YouShouldKnow', 'explainlikeimfive', 'trees', 'LifeProTips', 'sex', 'Fitness', 'lifehacks', 'politics', 'worldnews', 'news', 'TrueReddit', 'technology', 'Android', 'programming', 'apple', 'dmt']
#     end
#     # @subreddits = ['wtf']
#     @subRand = @subreddits.sample
#     
#     reddit = Snoo::Client.new do |con|
#       con.adapter :em_http
#     end
#     
#     if Rails.cache.read("parent_#{@subRand}").nil?
#       parent = Rails.cache.fetch("parent_#{@subRand}") do 
#         reddit.get_listing(subreddit: @subRand, sort: 'hot', limit: 7)["data"]["children"]
#       end
#       
#       comment = Rails.cache.fetch("comment_#{@subRand}") do 
#         commentsArray = []
#         parent.each do |a|
#           id = a["data"]["id"]
#           commentsArray.push(reddit.get_comments(link_id: id, sort: "best", limit: 1)[1]["data"]["children"])
#         end
#         commentsArray
#       end
#       parentComment = nil
#       if Rails.cache.read("expire_#{@subRand}").nil?
#         RedditWorker.perform_in(1.minute, @subRand)
#       end
#     else
#       if Rails.cache.read("expire_#{@subRand}").nil?
#         RedditWorker.perform_in(1.minute, @subRand)
#       end
#       parentComment = Rails.cache.read_multi("parent_#{@subRand}", "comment_#{@subRand}")
#     end
#     
#     # Rails.cache.delete('subreddits')
# #     Rails.cache.delete("parent_#{@subRand}")
# #     Rails.cache.delete("comment_#{@subRand}")
#     
#     rand = rand(0..6)
#     if !parentComment.nil?
#       @parentLink = parentComment["parent_#{@subRand}"][rand]["data"]
#       @firstParentComment = parentComment["comment_#{@subRand}"][rand]
#     else
#       @parentLink = parent[rand]["data"]
#       @firstParentComment = comment[rand]
#     end
#     
#     @title = @parentLink["title"]
#     @numComments = @parentLink["num_comments"]
#     @url = @parentLink["permalink"]
#     if !@parentLink["url"].include?("reddit")
#       @externalLink = @parentLink["url"]
#     else
#       @externalLink = nil
#     end
# 
#     if !@firstParentComment.empty?
#       @parentComment = @firstParentComment[0]["data"]
#       @author = @parentComment["author"]
#       @comment = @parentComment["body"]
#       @points = @parentComment["ups"]
#       @time = DateTime.strptime(@parentComment["created_utc"].to_s, '%s').to_s
#     
#       @clicks.update_attribute(:score, @clicks.score += 1)
#     end
     # 
     @agent = Mechanize.new
     
     if Rails.cache.read("HNparent").nil?
       agent = Mechanize.new
       
       hnparent = Rails.cache.fetch("HNparent") do
         RubyHackernews::Entry.all.sample
       end
       
       hncomment = Rails.cache.fetch("HNcomment") do 
         hncommentsArray = []
           hnparent.each do |a|
             url = a.comments_url
             hncommentsArray.push(agent.get(url).search(".default")[1].to_s)
           end
         hncommentsArray
       end
       
       # hncomment = Rails.cache.fetch("HNcomment") do 
#          hncommentsArray = []
#            hnparent.each do |a|
#              url = a.comments_url
#              hncommentsArray.push(agent.get(url).search(".default")[1].search(".comment").text)
#            end
#          hncommentsArray
#        end
#        
#        hnauthor = Rails.cache.fetch("HNauthor") do 
#          hnauthorsArray = []
#          agent = Mechanize.new
#            hnparent.each do |a|
#              url = a.comments_url
#              hnauthorsArray.push(agent.get(url).search(".default")[1].search("a").first.text)
#            end
#          hnauthorsArray
#        end
#        
#        hntime = Rails.cache.fetch("HNtime") do 
#          hntimesArray = []
#          agent = Mechanize.new
#            hnparent.each do |a|
#              url = a.comments_url
#              hntimesArray.push(agent.get(url).search(".comhead").text.split[1..3].join(' '))
#            end
#          hntimesArray
#        end
       
       hnparentComment = nil
     else
       hnparentComment = Rails.cache.read_multi("HNparent", "HNcomment", "HNauthor", "HNtime")
     end
     
     @HNparent = hnparentComment
     
     
     Rails.cache.delete("HNparent")
     Rails.cache.delete("HNcomment")
#      Rails.cache.delete("HNauthor")
#      Rails.cache.delete("HNtime")
     
     # @HN = RubyHackernews::Entry.all
 #     @HNparent = @HN.sample
 #     @HNtitle = @HNparent.link.title
 #     @HNexternalLink = @HNparent.link.site
 #     @HNnumComments = @HNparent.comments_count 
 #     @HNpoints = @HNparent.voting.score  
 #     @HNurl = @HNparent.comments_url
 #     
 #     # @HNparentComment = Nokogiri::HTML(open(@HNurl)).css(".default").first
 #     agent = Mechanize.new
     # @HNparentComment = @agent.get('https://news.ycombinator.com/item?id=6625135').search(".default")[1].search(".comment").text
 #     @HNauthor = @agent.get('https://news.ycombinator.com/item?id=6625135').search(".default")[1].search("a").first.text
 #     @HNtime = @agent.get('https://news.ycombinator.com/item?id=6625135').search(".default")[1].search(".comhead").text.split[1..3].join(' ')

  end

  def about
  end

  def contact
  end
end
