class CreateImgurs < ActiveRecord::Migration
  def change
    create_table :imgurs do |t|
      t.string :title
      t.integer :numComments
      t.string :imgurID
      t.string :pictureLink
      t.string :author
      t.text :comment
      t.integer :points
      t.string :time

      t.timestamps
    end
  end
end
