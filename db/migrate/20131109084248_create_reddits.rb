class CreateReddits < ActiveRecord::Migration
  def change
    create_table :reddits do |t|
      t.string :subreddit
      t.text :title, :limit => nil
      t.integer :numComments
      t.string :url
      t.string :externalLink
      t.string :author
      t.text :comment, :limit => nil
      t.integer :points
      t.string :time

      t.timestamps
    end
  end
end
