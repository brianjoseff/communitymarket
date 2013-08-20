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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130820014619) do

  create_table "assets", :force => true do |t|
    t.integer  "imageable_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "imageable_type"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "assignments", :force => true do |t|
    t.integer  "post_id"
    t.integer  "group_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "daily_queues", :force => true do |t|
    t.integer  "post_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "group_id"
    t.integer  "sender_id"
  end

  create_table "email_settings", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "followships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "group_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "group_category"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "user_id"
    t.integer  "group_category_id"
    t.boolean  "private"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "zipcode"
  end

  create_table "images", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "memberships", :force => true do |t|
    t.integer  "group_id"
    t.integer  "member_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "email_setting_id"
  end

  create_table "post_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.boolean  "borrow"
    t.integer  "tier_id"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "post_category_id"
    t.boolean  "premium"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "email"
    t.boolean  "cash"
    t.integer  "price"
    t.boolean  "active",           :default => true
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "post_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "tiers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "transactions", :force => true do |t|
    t.integer  "price"
    t.integer  "tier_id"
    t.boolean  "premium"
    t.integer  "notify_premium"
    t.integer  "user_id"
    t.integer  "customer_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "email"
    t.integer  "post_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "name"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "encrypted_password", :limit => 128
    t.string   "salt",               :limit => 128
    t.string   "confirmation_token", :limit => 128
    t.string   "remember_token",     :limit => 128
    t.string   "stripe_customer_id"
    t.string   "password"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

  create_table "weekly_queues", :force => true do |t|
    t.integer  "post_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "group_id"
    t.integer  "sender_id"
  end

end
