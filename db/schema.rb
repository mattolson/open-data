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

ActiveRecord::Schema.define(:version => 20100831034916) do

  create_table "applications", :force => true do |t|
    t.string   "title",                                  :null => false
    t.text     "description"
    t.string   "submitter_name",                         :null => false
    t.string   "submitter_email",                        :null => false
    t.string   "author_link"
    t.string   "application_link",                       :null => false
    t.string   "screenshot_filename"
    t.datetime "submitted_at",                           :null => false
    t.datetime "published_at"
    t.boolean  "is_featured",         :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", :force => true do |t|
    t.string   "name",                               :null => false
    t.text     "description"
    t.string   "link"
    t.string   "submitter_name",                     :null => false
    t.string   "submitter_email",                    :null => false
    t.string   "logo_filename"
    t.datetime "submitted_at",                       :null => false
    t.datetime "published_at"
    t.boolean  "is_partner",      :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dataset_files", :force => true do |t|
    t.integer  "dataset_id", :null => false
    t.string   "filename",   :null => false
    t.string   "mime_type",  :null => false
    t.integer  "size",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "datasets", :force => true do |t|
    t.string   "title",                               :null => false
    t.text     "description"
    t.datetime "published_at",                        :null => false
    t.datetime "last_uploaded_at"
    t.boolean  "is_featured",      :default => false, :null => false
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "download_count",   :default => 0,     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "datasets_applications", :force => true do |t|
    t.integer "dataset_id",     :null => false
    t.integer "application_id", :null => false
  end

  create_table "press_items", :force => true do |t|
    t.string   "title",        :null => false
    t.text     "blurb"
    t.string   "link"
    t.datetime "published_at", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                                  :null => false
    t.string   "email",                                  :null => false
    t.string   "crypted_password",                       :null => false
    t.string   "password_salt",                          :null => false
    t.string   "persistence_token",                      :null => false
    t.string   "single_access_token",                    :null => false
    t.string   "perishable_token",                       :null => false
    t.boolean  "is_admin",            :default => false, :null => false
    t.integer  "login_count",         :default => 0,     :null => false
    t.integer  "failed_login_count",  :default => 0,     :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
