class Comment < ActiveRecord::Base
  # after_commit :flush_cache
#   
#   def self.cache_first
#     Rails.cache.fetch([name, "score"]) { self.first }
#   end
#   
#   def flush_cache
#     Rails.cache.delete([self.class.name, "score"])
#   end
end
