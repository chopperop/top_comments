# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20131109072432) do

  create_table "comments", force: true do |t|
    t.string   "name"
    t.integer  "score",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "imgurs", force: true do |t|
    t.string   "title"
    t.integer  "numComments"
    t.string   "imgurID"
    t.string   "pictureLink"
    t.string   "author"
    t.text     "comment"
    t.integer  "points"
    t.string   "time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reddits", force: true do |t|
    t.string   "subreddit"
    t.string   "title"
    t.integer  "numComments"
    t.string   "url"
    t.string   "externalLink"
    t.string   "author"
    t.text     "comment"
    t.integer  "points"
    t.string   "time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
