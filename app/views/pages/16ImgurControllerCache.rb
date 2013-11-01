require 'rubygems'
require 'snoo'
require 'httparty'

class PagesController < ApplicationController
  def home
    # if Comment.all.count == 0
    #    Comment.create(:name => "clicks")
    # end
    
    @clicks = Comment.first
    
    if Rails.cache.read("parent_imgur").nil?
      header = { "Authorization" => "Client-ID 297eb3983f1727e" }
      url = "https://api.imgur.com/3/gallery/hot/time.json"
      
      parent = Rails.cache.fetch("parent_imgur") do 
        HTTParty.get(url, :headers => header )["data"][0..6]
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
      end
    else
      if Rails.cache.read("expire_imgur").nil?
        RedditWorker.perform_in(1.minute)
      end
      parentComment = Rails.cache.read_multi("parent_imgur", "comment_imgur")
    end
    
    header = { "Authorization" => "Client-ID 297eb3983f1727e" }
    url = "https://api.imgur.com/3/gallery/hot/time.json"
    @imgur = HTTParty.get(url, :headers => header )["data"]
    rand = rand(0..(@imgur.size))
    @Ititle = @imgur[rand]["title"]
    @Iid = @imgur[rand]["id"]
    @IpictureLink = @imgur[rand]["link"]
    commentsUrl = "https://api.imgur.com/3/gallery/image/#{@Iid}/comments.json"
    @IparentComments = HTTParty.get(commentsUrl, headers: header)["data"]
    @InumComments = @IparentComments.size
    
    if @InumComments != 0
      comRand = rand(0..(@InumComments/5))
      @Iauthor = @IparentComments[comRand]["author"]
      @Ipoints = @IparentComments[comRand]["points"]
      @Icomment = @IparentComments[comRand]["comment"]
      @IUnEdtime = @IparentComments[comRand]["datetime"]
      @Itime = DateTime.strptime(@IUnEdtime.to_s, '%s').to_s
      
      @clicks.update_attribute(:score, @clicks.score += 1)
    end
  
  end

  def about
  end

  def contact
  end
end