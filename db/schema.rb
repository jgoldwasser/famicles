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

ActiveRecord::Schema.define(:version => 20081011041853) do

  create_table "college_attendances", :force => true do |t|
    t.integer  "profile_id", :null => false
    t.integer  "college_id", :null => false
    t.integer  "class_year"
    t.string   "major"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "colleges", :force => true do |t|
    t.string   "name",       :default => "", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contact_infos", :force => true do |t|
    t.integer  "profile_id",                  :null => false
    t.string   "address"
    t.string   "city",         :limit => 50
    t.string   "state",        :limit => 50
    t.string   "postal_code",  :limit => 20
    t.string   "land_phone",   :limit => 20
    t.string   "mobile_phone", :limit => 20
    t.string   "websites",     :limit => 500
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "email_addresses", :force => true do |t|
    t.integer  "contact_info_id",                 :null => false
    t.string   "email",           :default => "", :null => false
    t.boolean  "validated",                       :null => false
    t.boolean  "default",                         :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employers", :force => true do |t|
    t.string   "name",       :default => "", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employments", :force => true do |t|
    t.integer  "profile_id",                 :null => false
    t.integer  "employer_id",                :null => false
    t.string   "position",    :limit => 100
    t.string   "location",    :limit => 50
    t.string   "start",       :limit => 20
    t.string   "end",         :limit => 20
    t.string   "description", :limit => 500
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "famicle_invitations", :force => true do |t|
    t.integer  "famicle_id",                             :null => false
    t.integer  "sender_id",                              :null => false
    t.integer  "receiver_id"
    t.string   "email"
    t.string   "state",           :default => "created", :null => false
    t.string   "invitation_code"
    t.datetime "sent_at"
    t.datetime "accepted_at"
    t.datetime "declined_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "famicle_memberships", :force => true do |t|
    t.integer  "user_id",                       :null => false
    t.integer  "famicle_id",                    :null => false
    t.string   "role",       :default => "",    :null => false
    t.boolean  "default",    :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "famicle_memberships", ["user_id"], :name => "index_famicle_memberships_on_user_id"
  add_index "famicle_memberships", ["famicle_id"], :name => "index_famicle_memberships_on_famicle_id"

  create_table "famicles", :force => true do |t|
    t.string   "name",                       :default => "", :null => false
    t.text     "description"
    t.integer  "public",        :limit => 1,                 :null => false
    t.string   "hometown"
    t.string   "most_resemble"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "high_school_attendances", :force => true do |t|
    t.integer  "profile_id",     :null => false
    t.integer  "high_school_id", :null => false
    t.integer  "class_year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "high_schools", :force => true do |t|
    t.string   "name",       :default => "", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "instant_message_accounts", :force => true do |t|
    t.integer  "contact_info_id",                 :null => false
    t.string   "name",            :default => "", :null => false
    t.string   "provider",        :default => "", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "passwords", :force => true do |t|
    t.integer  "user_id"
    t.string   "reset_code"
    t.datetime "expiration_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profile_photos", :force => true do |t|
    t.integer  "profile_id"
    t.integer  "parent_id"
    t.string   "content_type", :default => "", :null => false
    t.string   "filename",     :default => "", :null => false
    t.string   "thumbnail"
    t.integer  "size",                         :null => false
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.integer  "user_id",                                                  :null => false
    t.string   "full_name",                :limit => 50,   :default => "", :null => false
    t.integer  "gender",                   :limit => 1,                    :null => false
    t.date     "birthdate",                                                :null => false
    t.integer  "public_birthdate_display", :limit => 1,                    :null => false
    t.string   "timezone",                 :limit => 50,   :default => "", :null => false
    t.string   "hometown",                 :limit => 100
    t.string   "political_view",           :limit => 100
    t.string   "religious_view",           :limit => 100
    t.string   "parenting_style",          :limit => 100
    t.string   "about_me",                 :limit => 2000
    t.string   "what_i_like",              :limit => 2000
    t.string   "what_i_do",                :limit => 2000
    t.string   "favorite_tv",              :limit => 2000
    t.string   "favorite_music",           :limit => 2000
    t.string   "favorite_sites",           :limit => 2000
    t.string   "favorite_movies",          :limit => 2000
    t.integer  "public",                   :limit => 1,                    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relationship_types", :force => true do |t|
    t.string   "name",       :default => "", :null => false
    t.string   "value",      :default => "", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relationships", :force => true do |t|
    t.integer  "user_id",              :null => false
    t.integer  "related_to_id",        :null => false
    t.integer  "relationship_type_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :default => "", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "state",                                    :default => "passive"
    t.datetime "deleted_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
