require 'rubygems'
require 'snoo'
require 'httparty'

class PagesController < ApplicationController
  def home
    # if Comment.all.count == 0
    #    Comment.create(:name => "clicks")
    # end
    
    @clicks = Comment.first
    
    @site = rand(1..100)
    
    if @site >= 31
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
          reddit.get_listing(subreddit: @subRand, sort: 'hot', limit: 7)["data"]["children"]
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
        if Rails.cache.read("expire_#{@subRand}").nil?
          RedditWorker.perform_in(1.minute, @subRand)
          Rails.cache.fetch("expire_#{@subRand}", expires_in: 31.minutes) { "wait period" }
        end
      else
        if Rails.cache.read("expire_#{@subRand}").nil?
          RedditWorker.perform_in(1.minute, @subRand)
          Rails.cache.fetch("expire_#{@subRand}", expires_in: 31.minutes) { "wait period" }
        end
        parentComment = Rails.cache.read_multi("parent_#{@subRand}", "comment_#{@subRand}")
      end
    
      # Rails.cache.delete('subreddits')
  #     Rails.cache.delete("parent_#{@subRand}")
  #     Rails.cache.delete("comment_#{@subRand}")
    
      rand = rand(0..6)
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
    else
      if Rails.cache.read("parent_imgur").nil?
        header = { "Authorization" => "Client-ID 297eb3983f1727e" }
        url = "https://api.imgur.com/3/gallery/hot/time.json"
      
        parent = Rails.cache.fetch("parent_imgur") do 
          HTTParty.get(url, :headers => header )["data"].sample(7)
        end
      
        comment = Rails.cache.fetch("comment_imgur") do 
          commentsArray = []
          parent.each do |a|
            id = a["id"]
            commentsUrl = "https://api.imgur.com/3/gallery/image/#{id}/comments.json"
            commentsArray.push(HTTParty.get(commentsUrl, headers: header)["data"])
          end
          commentsArray
        end
        parentComment = nil
        if Rails.cache.read("expire_imgur").nil?
          ImgurWorker.perform_in(1.minute)
          Rails.cache.fetch("expire_imgur", expires_in: 6.minutes) { "wait period" }
        end
      else
        if Rails.cache.read("expire_imgur").nil?
          ImgurWorker.perform_in(1.minute)
          Rails.cache.fetch("expire_imgur", expires_in: 6.minutes) { "wait period" }
        end
        parentComment = Rails.cache.read_multi("parent_imgur", "comment_imgur")
      end
    
      # Rails.cache.delete("parent_imgur")
      # Rails.cache.delete("comment_imgur")
      # Rails.cache.delete("expire_imgur")
    
      rand = rand(0..6)
      if !parentComment.nil?
        @IparentLink = parentComment["parent_imgur"][rand]
        @IfirstParentComment = parentComment["comment_imgur"][rand]
      else
        @IparentLink = parent[rand]
        @IfirstParentComment = comment[rand]
      end
      @Ititle = @IparentLink["title"]
      @Iid = @IparentLink["id"]
      @IpictureLink = @IparentLink["link"]
      @InumComments = @IfirstParentComment.size
    
      if @InumComments != 0
        comRand = rand(0..(@InumComments/5))
        @Iauthor = @IfirstParentComment[comRand]["author"]
        @Ipoints = @IfirstParentComment[comRand]["points"]
        @Icomment = @IfirstParentComment[comRand]["comment"]
        @IUnEdtime = @IfirstParentComment[comRand]["datetime"]
        @Itime = DateTime.strptime(@IUnEdtime.to_s, '%s').to_s
      
        @clicks.update_attribute(:score, @clicks.score += 1)
      end
    end
  
  end

  def about
  end

  def contact
  end
end