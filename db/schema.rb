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

ActiveRecord::Schema.define(:version => 20110821133356) do

  create_table "answer_bodies", :force => true do |t|
    t.text     "body"
    t.text     "formatted_html"
    t.integer  "answer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answer_bodies", ["answer_id"], :name => "index_answer_bodies_on_answer_id"

  create_table "answers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "vote_points",    :default => 0
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comments_count", :default => 0
  end

  add_index "answers", ["question_id"], :name => "index_answers_on_question_id"
  add_index "answers", ["user_id"], :name => "index_answers_on_user_id"

  create_table "authentications", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.string   "token"
    t.string   "secret"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authentications", ["user_id"], :name => "index_authentications_on_user_id"

  create_table "backup", :force => true do |t|
    t.string   "trigger"
    t.string   "adapter"
    t.string   "filename"
    t.string   "md5sum"
    t.string   "path"
    t.string   "bucket"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blog_posts", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comments_count", :default => 0
  end

  add_index "blog_posts", ["user_id"], :name => "index_blog_posts_on_user_id"

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

  create_table "job_job_types", :force => true do |t|
    t.integer  "job_id"
    t.integer  "job_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "job_job_types", ["job_id"], :name => "index_job_job_types_on_job_id"
  add_index "job_job_types", ["job_type_id"], :name => "index_job_job_types_on_job_type_id"

  create_table "job_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobs", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "company"
    t.string   "company_url"
    t.string   "country"
    t.string   "state"
    t.string   "city"
    t.string   "address"
    t.string   "salary"
    t.string   "apply_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "published"
  end

  add_index "jobs", ["user_id"], :name => "index_jobs_on_user_id"

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

  create_table "post_bodies", :force => true do |t|
    t.text     "body"
    t.text     "formatted_html"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "post_bodies", ["post_id"], :name => "index_post_bodies_on_post_id"

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.text     "description",    :limit => 16777215
    t.integer  "comments_count",                     :default => 0
    t.integer  "vote_points",                        :default => 0
    t.integer  "view_count"
    t.boolean  "implemented",                        :default => false, :null => false
    t.boolean  "published",                          :default => false, :null => false
  end

  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "question_bodies", :force => true do |t|
    t.text     "body"
    t.text     "formatted_html"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "question_bodies", ["question_id"], :name => "index_question_bodies_on_question_id"

  create_table "questions", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.integer  "vote_points",    :default => 0
    t.integer  "view_count",     :default => 0
    t.integer  "answers_count",  :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comments_count", :default => 0
  end

  add_index "questions", ["user_id"], :name => "index_questions_on_user_id"

  create_table "rails_admin_histories", :force => true do |t|
    t.string   "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "sponsor_tracks", :force => true do |t|
    t.integer  "sponsor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sponsor_tracks", ["sponsor_id"], :name => "index_sponsor_tracks_on_sponsor_id"

  create_table "sponsors", :force => true do |t|
    t.string   "name"
    t.string   "website_url"
    t.string   "image_url"
    t.boolean  "active",      :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
  add_index "taggings", ["tagger_id", "tagger_type"], :name => "index_taggings_on_tagger_id_and_tagger_type"

  create_table "tags", :force => true do |t|
    t.string  "name"
    t.boolean "important", :default => true, :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
    t.integer  "posts_count",               :default => 0,     :null => false
    t.integer  "comments_count",            :default => 0,     :null => false
    t.integer  "votes_count",               :default => 0,     :null => false
    t.integer  "active_token_id"
    t.integer  "questions_count",           :default => 0,     :null => false
    t.integer  "answers_count",             :default => 0,     :null => false
    t.integer  "unread_notification_count", :default => 0,     :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.boolean  "admin",                     :default => false, :null => false
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

end
