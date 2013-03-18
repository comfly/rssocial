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

ActiveRecord::Schema.define(version: 20130318101019) do

  create_table "categories", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "entries", force: true do |t|
    t.string   "title"
    t.string   "url",        null: false
    t.string   "author"
    t.text     "summary"
    t.text     "content"
    t.datetime "published",  null: false
    t.string   "tags"
    t.integer  "feed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "entry_statuses", force: true do |t|
    t.boolean  "read",       default: false, null: false
    t.boolean  "starred",    default: false, null: false
    t.integer  "entry_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "feeds", force: true do |t|
    t.string   "title"
    t.string   "url",           null: false
    t.string   "feed_url",      null: false
    t.string   "etag"
    t.datetime "last_modified", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_scanned"
  end

  create_table "subscriptions", force: true do |t|
    t.integer "user_id"
    t.integer "feed_id"
    t.integer "category_id"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email",      null: false
    t.string   "password",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
