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
    # Rails.cache.fetch("expire_imgur", expires_in: 4.minutes) { "wait period" }
  end
end