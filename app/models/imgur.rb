class Imgur < ActiveRecord::Base
  after_commit :flush_cache
  
  def self.cached_find(id)
    Rails.cache.fetch([id, "imgur"]) { find(id) }
  end

  def self.cached_find_by_comment(comment)
    Rails.cache.fetch(comment) { find_by_comment(comment) }
  end

  def flush_cache
    Rails.cache.delete([id, "imgur"])
    Rails.cache.delete(comment)
  end
end
