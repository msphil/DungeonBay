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

ActiveRecord::Schema.define(:version => 20120416061823) do

  create_table "auctions", :force => true do |t|
    t.integer  "creator_id"
    t.integer  "item_id"
    t.string   "description"
    t.integer  "open_bid"
    t.integer  "buyout_price"
    t.datetime "expires"
    t.integer  "current_bid"
    t.integer  "bidder_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "auctions", ["creator_id", "item_id"], :name => "index_auctions_on_creator_id_and_item_id"
  add_index "auctions", ["current_bid", "bidder_id"], :name => "index_auctions_on_current_bid_and_bidder_id"
  add_index "auctions", ["expires"], :name => "index_auctions_on_expires"

  create_table "campaigns", :force => true do |t|
    t.integer  "owner_id"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "campaigns", ["owner_id"], :name => "index_campaigns_on_owner_id"

  create_table "characters", :force => true do |t|
    t.integer  "owner_id"
    t.integer  "campaign_id"
    t.string   "name"
    t.string   "description"
    t.integer  "gold"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "characters", ["name"], :name => "index_characters_on_name"
  add_index "characters", ["owner_id", "campaign_id"], :name => "index_characters_on_owner_id_and_campaign_id"

  create_table "items", :force => true do |t|
    t.integer  "creator_id"
    t.integer  "owner_id"
    t.integer  "campaign_id"
    t.string   "image_url"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "items", ["creator_id"], :name => "index_items_on_creator_id"
  add_index "items", ["description"], :name => "index_items_on_description"
  add_index "items", ["owner_id", "campaign_id"], :name => "index_items_on_owner_id_and_campaign_id"

  create_table "memberships", :force => true do |t|
    t.integer  "character_id"
    t.integer  "campaign_id"
    t.boolean  "gm"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memberships", ["character_id", "campaign_id"], :name => "index_memberships_on_character_id_and_campaign_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
