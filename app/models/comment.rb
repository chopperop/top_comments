class Comment < ActiveRecord::Base
  after_commit :flush_cache
  
  def self.cache_first
    Rails.cache.fetch("comment_score") { self.first }
  end
  
  def flush_cache
    Rails.cache.delete("comment_score")
  end
end
