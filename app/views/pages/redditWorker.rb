    if Rails.cache.read("parent1_#{sub}").nil? && Rails.cache.read("parent2_#{sub}").nil?
      Rails.cache.fetch("parent2_#{sub}", expires_in: 1.hour) do
        reddit.get_listing(subreddit: sub, sort: 'hot', limit: 7)["data"]["children"]
      end
    
      Rails.cache.fetch("comment2_#{sub}", expires_in: 1.hour) do 
        commentsArray = []
        parent.each do |a|
          id = a["data"]["id"]
          commentsArray.push(reddit.get_comments(link_id: id, sort: "best", limit: 1)[1]["data"]["children"])
        end
        commentsArray
      end
      if Rails.cache.read("parent1_sidekiq_#{sub}").nil?
        Rails.cache.fetch("parent1_sidekiq_#{sub}", expires_in: 30.minutes) { "sending parent1 job" }
        perform_in(30.minutes, sub)
      end
      if Rails.cache.read("parent2_sidekiq_#{sub}").nil?
        Rails.cache.fetch("parent2_sidekiq_#{sub}", expires_in: 30.minutes) { "sending parent2 job" }
        perform_in(30.minutes, sub)
      end
    elsif Rails.cache.read("parent1_#{sub}").nil? && !Rails.cache.read("parent2_#{sub}").nil?
      Rails.cache.fetch("parent1_#{sub}", expires_in: 1.hour) do
        reddit.get_listing(subreddit: sub, sort: 'hot', limit: 7)["data"]["children"]
      end
  
      Rails.cache.fetch("comment1_#{sub}", expires_in: 1.hour) do 
        commentsArray = []
        parent.each do |a|
          id = a["data"]["id"]
          commentsArray.push(reddit.get_comments(link_id: id, sort: "best", limit: 1)[1]["data"]["children"])
        end
        commentsArray
      end
      if Rails.cache.read("parent1_sidekiq_#{sub}").nil?
        Rails.cache.fetch("parent1_sidekiq_#{sub}", expires_in: 30.minutes) { "sending parent1 job" }
        perform_in(30.minutes, sub)
      end
      if Rails.cache.read("parent2_sidekiq_#{sub}").nil?
        Rails.cache.fetch("parent2_sidekiq_#{sub}", expires_in: 30.minutes) { "sending parent2 job" }
        perform_in(30.minutes, sub)
      end
    elsif !Rails.cache.read("parent1_#{sub}").nil? && Rails.cache.read("parent2_#{sub}").nil? 
      Rails.cache.fetch("parent2_#{sub}", expires_in: 1.hour) do
        reddit.get_listing(subreddit: sub, sort: 'hot', limit: 7)["data"]["children"]
      end
    
      Rails.cache.fetch("comment2_#{sub}", expires_in: 1.hour) do 
        commentsArray = []
        parent.each do |a|
          id = a["data"]["id"]
          commentsArray.push(reddit.get_comments(link_id: id, sort: "best", limit: 1)[1]["data"]["children"])
        end
        commentsArray
      end
      if Rails.cache.read("parent1_sidekiq_#{sub}").nil?
        Rails.cache.fetch("parent1_sidekiq_#{sub}", expires_in: 30.minutes) { "sending parent1 job" }
        perform_in(30.minutes, sub)
      end
      if Rails.cache.read("parent2_sidekiq_#{sub}").nil?
        Rails.cache.fetch("parent2_sidekiq_#{sub}", expires_in: 30.minutes) { "sending parent2 job" }
        perform_in(30.minutes, sub)
      end
    elsif !Rails.cache.read("parent1_#{sub}").nil? && !Rails.cache.read("parent2_#{sub}").nil? 
      Rails.cache.fetch("parent2_#{sub}", expires_in: 1.hour) do
        reddit.get_listing(subreddit: sub, sort: 'hot', limit: 7)["data"]["children"]
      end
    
      Rails.cache.fetch("comment2_#{sub}", expires_in: 1.hour) do 
        commentsArray = []
        parent.each do |a|
          id = a["data"]["id"]
          commentsArray.push(reddit.get_comments(link_id: id, sort: "best", limit: 1)[1]["data"]["children"])
        end
        commentsArray
      end
      # if Rails.cache.read("parent2_sidekiq_#{sub}").nil?
#         Rails.cache.fetch("parent2_sidekiq_#{sub}", expires_in: 30.minutes) { "sending parent2 job" }
#         perform_in(30.minutes, sub)
#       end
    end