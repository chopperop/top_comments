class AddSubredditToReddits < ActiveRecord::Migration
  def change
    add_column :reddits, :subreddit, :string
  end
end
