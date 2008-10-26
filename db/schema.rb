# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20081021183526) do

  create_table "adresses", :force => true do |t|
    t.string   "uri"
    t.string   "path"
    t.string   "title"
    t.integer  "domain_id"
    t.text     "description"
    t.datetime "crawled_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "domains", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "test_results", :force => true do |t|
    t.integer  "adress_id"
    t.integer  "response_size"
    t.float    "response_time"
    t.string   "title"
    t.string   "description"
    t.string   "measurement"
    t.string   "response_code"
    t.string   "test_path"
    t.string   "cache_control"
    t.string   "content_type"
    t.string   "date"
    t.string   "server"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
