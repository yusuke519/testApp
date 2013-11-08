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

ActiveRecord::Schema.define(version: 20131108081128) do

  create_table "accelerations", force: true do |t|
    t.integer  "sequence"
    t.string   "time"
    t.float    "x"
    t.float    "y"
    t.float    "z"
    t.string   "data_point_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "data_points", force: true do |t|
    t.string   "start_time"
    t.string   "stop_time"
    t.string   "data_type"
    t.string   "stream_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "from_lat"
    t.float    "from_lng"
    t.float    "to_lat"
    t.float    "to_lng"
  end

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "results", force: true do |t|
    t.string   "data_point_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "value"
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at"

  create_table "streams", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_id"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
