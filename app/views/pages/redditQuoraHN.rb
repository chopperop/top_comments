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
     @HN = RubyHackernews::Entry.all
     @HNparent = @HN.sample
     @HNtitle = @HNparent.link.title
     @HNexternalLink = @HNparent.link.site
     @HNnumComments = @HNparent.comments_count 
     @HNpoints = @HNparent.voting.score  
     @HNurl = @HNparent.comments_url
     
     # @HNparentComment = Nokogiri::HTML(open(@HNurl)).css(".default").first
     agent = Mechanize.new
     @HNparentComment = agent.get('https://news.ycombinator.com/item?id=6625135').search(".default")[1]
     @HNauthor = @HNparentComment
     @HNtime = @HNparentComment
     
     # agent = Mechanize.new
#      page = agent.get('http://www.quora.com/login')
#      form = page.forms.first
#      email = form.field_with(:name => "email")
#      email.value = "david.wu712@gmail.com"
#      password = form.field_with(:name => "password")
#      password.value = "david12"
#      form.submit
     # form.email = "david.wu712@gmail.com"
#      form.password = "david12"
#      @page = agent.submit(form, form.buttons.first)
     
     #      #@link = agent.page.links[40].attributes
     #      #@link = agent.page.links_with(:href => '/katieheaney')[0].click.search('#facebook_comments_wrapper')
     #      @link = page.search('div[id*=container]')[2]# agent = Mechanize.new
     
      # httpc = HTTPClient.new
 #      resp = httpc.head('http://www.quora.com/shuffle', :follow_redirect => true)
 #      @Qurl =  resp.header.request_uri
 #      page = Nokogiri::HTML(open(@Qurl))
 #      @Qtitle = page.css('h1').text
 #      @QnumComments = page.css('span.light a').last.text.split(' ').drop(2).join(' ')
 #      @Qpoints = page.css('.numbers')[0].text
 #      @Qcomment = page.css('div[id*=container]')[1].text
 #      @Qauthor = page.css('.answer_user_wrapper a')[1].css('a').text
 #      @QauthorText = page.css('.answer_user_wrapper')[1].css('span[id*=full_text_content]').text
 #      @Qtime = page.css('.answer_permalink')[0].text
  end

  def about
  end

  def contact
  end
end
