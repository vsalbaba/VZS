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

ActiveRecord::Schema.define(:version => 20140517102139) do

  create_table "addresses", :force => true do |t|
    t.string   "street"
    t.string   "house_number"
    t.string   "city"
    t.string   "postcode"
    t.integer  "profile_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.boolean  "commentable"
    t.integer  "group"
    t.boolean  "sticky"
    t.boolean  "approved"
  end

  create_table "attachments", :force => true do |t|
    t.integer  "article_id"
    t.integer  "user_id"
    t.string   "name"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "audits", :force => true do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "associated_id"
    t.string   "associated_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "audited_changes"
    t.integer  "version",         :default => 0
    t.string   "comment"
    t.string   "remote_address"
    t.datetime "created_at"
  end

  add_index "audits", ["associated_id", "associated_type"], :name => "associated_index"
  add_index "audits", ["auditable_id", "auditable_type"], :name => "auditable_index"
  add_index "audits", ["created_at"], :name => "index_audits_on_created_at"
  add_index "audits", ["user_id", "user_type"], :name => "user_index"

  create_table "brigades", :force => true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.integer  "hours"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "comments", :force => true do |t|
    t.integer  "article_id"
    t.integer  "user_id"
    t.text     "message"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.datetime "start_datetime"
    t.datetime "end_datetime"
    t.string   "place"
    t.string   "event_type"
    t.string   "link"
    t.integer  "group"
  end

  create_table "galleries", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "group"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "description"
    t.integer  "article_id"
  end

  add_index "galleries", ["user_id"], :name => "index_galleries_on_user_id"

  create_table "life_guarding_timespans", :force => true do |t|
    t.date     "from"
    t.date     "to"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "life_guards", :force => true do |t|
    t.integer  "life_guarding_timespan_id"
    t.integer  "profile_id"
    t.integer  "position"
    t.date     "at"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "person_text"
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.string   "menu_title"
    t.text     "content"
    t.boolean  "navbar"
    t.boolean  "menu"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "participations", :force => true do |t|
    t.integer  "event_id"
    t.integer  "profile_id"
    t.integer  "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "photos", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "gallery_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "position"
  end

  add_index "photos", ["user_id"], :name => "index_photos_on_user_id"

  create_table "profiles", :force => true do |t|
    t.string   "first_name"
    t.string   "second_name"
    t.string   "email"
    t.string   "telephone"
    t.string   "im_jabber"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "user_id"
    t.date     "birthdate"
    t.string   "birthnumber"
    t.string   "vzs_id"
  end

  create_table "profiles_trainings", :force => true do |t|
    t.integer "profile_id"
    t.integer "training_id"
  end

  create_table "qualifications", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "abbreviation"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "trainings", :force => true do |t|
    t.datetime "date"
    t.string   "program"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "group"
    t.integer  "login_count",        :default => 0, :null => false
    t.integer  "failed_login_count", :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
  end

  create_table "valid_qualification", :force => true do |t|
    t.integer  "profile_id"
    t.integer  "qualification_id"
    t.date     "valid_from"
    t.date     "valid_to"
    t.integer  "created_by"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "works", :force => true do |t|
    t.string   "text"
    t.integer  "ammount"
    t.integer  "work_type"
    t.integer  "profile_id"
    t.integer  "event_id"
    t.datetime "at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
