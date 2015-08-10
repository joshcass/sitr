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

ActiveRecord::Schema.define(version: 20150810004946) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "feed_times", force: :cascade do |t|
    t.time     "time"
    t.integer  "pet_feeder_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "feed_times", ["pet_feeder_id"], name: "index_feed_times_on_pet_feeder_id", using: :btree

  create_table "nests", force: :cascade do |t|
    t.string   "token"
    t.string   "expiration"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "nests", ["user_id"], name: "index_nests_on_user_id", using: :btree

  create_table "pet_feeders", force: :cascade do |t|
    t.string   "url"
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "pet_feeders", ["user_id"], name: "index_pet_feeders_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "screen_name"
    t.string   "uid"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "time_zone"
  end

  create_table "video_feeds", force: :cascade do |t|
    t.string   "location"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "video_feeds", ["user_id"], name: "index_video_feeds_on_user_id", using: :btree

  add_foreign_key "feed_times", "pet_feeders"
  add_foreign_key "nests", "users"
  add_foreign_key "pet_feeders", "users"
  add_foreign_key "video_feeds", "users"
end
