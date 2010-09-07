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

ActiveRecord::Schema.define(:version => 20100907000817) do

  create_table "admins", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",                     :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true
  add_index "admins", ["unlock_token"], :name => "index_admins_on_unlock_token", :unique => true

  create_table "apps", :force => true do |t|
    t.string   "title",                               :null => false
    t.text     "description"
    t.string   "submitter_name",                      :null => false
    t.string   "submitter_email",                     :null => false
    t.string   "author_link"
    t.string   "application_link",                    :null => false
    t.datetime "submitted_at",                        :null => false
    t.datetime "published_at"
    t.boolean  "is_featured",      :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "apps_datasets", :force => true do |t|
    t.integer "dataset_id", :null => false
    t.integer "app_id",     :null => false
  end

  create_table "attachments", :force => true do |t|
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attachments", ["attachable_id", "attachable_type"], :name => "index_attachments_on_attachable_id_and_attachable_type"

  create_table "companies", :force => true do |t|
    t.string   "name",                               :null => false
    t.text     "description"
    t.string   "link"
    t.string   "submitter_name",                     :null => false
    t.string   "submitter_email",                    :null => false
    t.datetime "submitted_at",                       :null => false
    t.datetime "published_at"
    t.boolean  "is_partner",      :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "datasets", :force => true do |t|
    t.string   "title",                               :null => false
    t.text     "description"
    t.datetime "last_uploaded_at"
    t.boolean  "is_featured",      :default => false, :null => false
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "download_count",   :default => 0,     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "press_items", :force => true do |t|
    t.string   "title",        :null => false
    t.text     "blurb"
    t.string   "link"
    t.datetime "published_at", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "taggable_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

end
