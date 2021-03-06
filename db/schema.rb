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

ActiveRecord::Schema.define(version: 20130831221211) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blog_post_comments", force: true do |t|
    t.integer  "blog_post_id",                  null: false
    t.integer  "votes"
    t.string   "author",                        null: false
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                         null: false
    t.integer  "respond_to_id"
    t.boolean  "approved",      default: false
  end

  create_table "blog_posts", force: true do |t|
    t.string   "title"
    t.string   "subtitle"
    t.string   "author"
    t.string   "categories"
    t.integer  "year"
    t.integer  "month"
    t.integer  "day"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "body"
    t.string   "file_name",             null: false
    t.string   "md5_hash",              null: false
    t.integer  "blog_post_comments_id"
    t.string   "banner_image"
  end

  add_index "blog_posts", ["blog_post_comments_id"], name: "index_blog_posts_on_blog_post_comments_id", using: :btree

  create_table "inquiries", force: true do |t|
    t.string   "author"
    t.string   "email"
    t.string   "phone"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.integer  "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
