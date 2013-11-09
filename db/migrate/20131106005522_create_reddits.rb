class CreateReddits < ActiveRecord::Migration
  def change
    create_table :reddits do |t|
      t.string :title
      t.integer :numComments
      t.string :url
      t.string :externalLink
      t.string :author
      t.string :comment
      t.integer :points
      t.string :time

      t.timestamps
    end
  end
end
