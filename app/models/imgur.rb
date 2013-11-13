class Imgur < ActiveRecord::Base
  after_commit :flush_cache
  
  def self.cached_find(id)
    Rails.cache.fetch([id, "imgur"]) { find(id) }
  end

  def self.cached_find_by_comment(com)
    summary = com.split(' ')[0..6].join(' ')
    Rails.cache.fetch(summary) { find_by_comment(com) }
  end

  def flush_cache
    Rails.cache.delete([id, "imgur"])
    Rails.cache.delete(comment.split(' ')[0..6].join(' '))
  end
  
  def to_param
    "#{id}-#{title}".parameterize
  end
end
