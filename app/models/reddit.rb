class Reddit < ActiveRecord::Base
  after_commit :flush_cache
  
  def self.cached_find(id)
    Rails.cache.fetch([id, "reddit"]) { find(id) }
  end

  def self.cached_find_by_comment(comment)
    Rails.cache.fetch(comment) { find_by_comment(comment) }
  end

  def flush_cache
    Rails.cache.delete([id, "reddit"])
    Rails.cache.delete(comment)
  end
end
