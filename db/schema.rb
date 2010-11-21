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

ActiveRecord::Schema.define(:version => 20101121145855) do

  create_table "access_tokens", :force => true do |t|
    t.integer  "user_id"
    t.string   "type",       :limit => 30
    t.string   "key"
    t.string   "token",      :limit => 1024
    t.string   "secret"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "access_tokens", ["key"], :name => "index_access_tokens_on_key", :unique => true
  add_index "access_tokens", ["user_id"], :name => "index_access_tokens_on_user_id"

  create_table "admin_users", :force => true do |t|
    t.string   "first_name",       :default => "",    :null => false
    t.string   "last_name",        :default => "",    :null => false
    t.string   "role",                                :null => false
    t.string   "email",                               :null => false
    t.boolean  "status",           :default => false
    t.string   "token",                               :null => false
    t.string   "salt",                                :null => false
    t.string   "crypted_password",                    :null => false
    t.string   "preferences"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "answers", :force => true do |t|
    t.text     "body",           :limit => 16777215
    t.text     "formatted_html", :limit => 16777215
    t.integer  "user_id"
    t.integer  "vote_points",                        :default => 0
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comments_count",                     :default => 0
  end

  add_index "answers", ["question_id"], :name => "index_answers_on_question_id"
  add_index "answers", ["user_id"], :name => "index_answers_on_user_id"

  create_table "comments", :force => true do |t|
    t.text     "body",             :limit => 16777215
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
  end

  add_index "comments", ["commentable_id", "commentable_type"], :name => "index_comments_on_commentable_id_and_commentable_type"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "drops", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.text     "formatted_html"
    t.text     "description"
    t.string   "kind"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tag_list"
  end

  add_index "drops", ["user_id"], :name => "index_drops_on_user_id"

  create_table "implementations", :force => true do |t|
    t.integer  "post_id"
    t.integer  "user_id"
    t.text     "body",           :limit => 16777215
    t.text     "formatted_html", :limit => 16777215
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "implementations", ["post_id"], :name => "index_implementations_on_post_id"
  add_index "implementations", ["user_id"], :name => "index_implementations_on_user_id"

  create_table "notification_settings", :force => true do |t|
    t.string   "name"
    t.boolean  "value",      :default => true
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notification_settings", ["user_id"], :name => "index_notification_settings_on_user_id"

  create_table "notifications", :force => true do |t|
    t.integer  "user_id"
    t.string   "notifierable_type"
    t.integer  "notifierable_id"
    t.boolean  "read",              :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notifications", ["notifierable_id", "notifierable_type"], :name => "index_notifications_on_notifierable_id_and_notifierable_type"
  add_index "notifications", ["user_id"], :name => "index_notifications_on_user_id"

  create_table "pages", :force => true do |t|
    t.string   "name"
    t.text     "body",       :limit => 16777215
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "body",           :limit => 16777215
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.text     "formatted_html", :limit => 16777215
    t.text     "description",    :limit => 16777215
    t.integer  "comments_count",                     :default => 0
    t.integer  "vote_points",                        :default => 0
    t.integer  "view_count"
    t.boolean  "implemented",                        :default => false, :null => false
  end

  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "questions", :force => true do |t|
    t.string   "title"
    t.text     "body",           :limit => 16777215
    t.text     "formatted_html", :limit => 16777215
    t.integer  "user_id"
    t.integer  "vote_points",                        :default => 0
    t.integer  "view_count",                         :default => 0
    t.integer  "answers_count",                      :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comments_count",                     :default => 0
  end

  add_index "questions", ["user_id"], :name => "index_questions_on_user_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"
  add_index "taggings", ["tagger_id"], :name => "index_taggings_on_tagger_id"

  create_table "tags", :force => true do |t|
    t.string  "name"
    t.boolean "important", :default => true, :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "single_access_token"
    t.string   "perishable_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
    t.boolean  "developer"
    t.integer  "posts_count",               :default => 0, :null => false
    t.integer  "implementations_count",     :default => 0, :null => false
    t.integer  "comments_count",            :default => 0, :null => false
    t.integer  "votes_count",               :default => 0, :null => false
    t.integer  "active_token_id"
    t.integer  "questions_count",           :default => 0, :null => false
    t.integer  "answers_count",             :default => 0, :null => false
    t.integer  "unread_notification_count", :default => 0, :null => false
  end

  add_index "users", ["active_token_id"], :name => "index_users_on_active_token_id"

  create_table "votes", :force => true do |t|
    t.boolean  "like"
    t.integer  "user_id"
    t.integer  "voteable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "voteable_type"
  end

  add_index "votes", ["user_id"], :name => "index_votes_on_user_id"
  add_index "votes", ["voteable_id", "voteable_type"], :name => "index_votes_on_voteable_id_and_voteable_type"
  add_index "votes", ["voteable_id"], :name => "index_votes_on_post_id"

end
