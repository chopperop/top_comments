require 'httparty'

class ImgurWorker
  include Sidekiq::Worker
  
  def perform
    header = { "Authorization" => "Client-ID 297eb3983f1727e" }
    url = "https://api.imgur.com/3/gallery/hot/time.json"
    
    parent = HTTParty.get(url, :headers => header )["data"].sample(7)
    Rails.cache.write("parent_imgur", parent) 
    
    commentsArray = []
    parent.each do |a|
      id = a["id"]
      commentsUrl = "https://api.imgur.com/3/gallery/image/#{id}/comments.json"
      commentsArray.push(HTTParty.get(commentsUrl, headers: header)["data"])
    end
    Rails.cache.write("comment_imgur", commentsArray)
    
    y = 0
    
    commentsArray.each do |comPar|
      if comPar.size != 0
        comArray = comPar[0..2]
        comArray.each do |com|
          parentPar = parent[x]
          title = parentPar["title"]
          numComments = com.size
          comID = parentPar["id"]
          pictureLink = parentPar["link"]
        
          author = com["author"]
          body = com["comment"]
          points = com["points"]
          time = DateTime.strptime(com["datetime"].to_s, '%s').to_s
          if Imgur.find_by_comment(body).nil?
            imgur = Imgur.create(title: title, numComments: numComments, imgurID: comID, pictureLink: pictureLink, author: author, comment: body, points: points, time: time)
          end
        end
      end
      y += 1
    end
    
    Imgur.where("created_at <= ?", 5.days.ago).delete_all
    
    # Rails.cache.fetch("expire_imgur", expires_in: 4.minutes) { "wait period" }
  end
end