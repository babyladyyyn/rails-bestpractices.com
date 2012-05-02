source 'http://rubygems.org'

gem 'rails'

gem 'mysql2'

gem "json"
gem "haml"
gem "kaminari"
gem "devise"
gem "omniauth"
gem "omniauth-facebook"
gem "omniauth-twitter"
gem "formtastic"
gem "has_scope"
gem 'exception_notification', :require => 'exception_notifier'
gem "acts-as-taggable-on"
gem "rdiscount"
gem "gravtastic"
gem "css_sprite"
gem "meta-tags", :require => 'meta_tags'
gem "sitemap_generator"
gem "twitter"
gem "bitly"
gem "cancan"
gem "recaptcha", :require => "recaptcha/rails"
gem 'whenever'
gem "thinking-sphinx", :require => 'thinking_sphinx'
gem "daemons"
gem "delayed_job_active_record"
gem "switch_user"
gem "dropbox"
gem "backup"
gem "escape_utils"
gem "newrelic_rpm"
gem "rails_admin", :git => 'git://github.com/sferik/rails_admin.git'
gem "paperclip"
gem "ckeditor_rails", :require => "ckeditor-rails"
gem "nokogiri"
gem "kgio"
gem "dalli"
gem "simple_cacheable", :require => "cacheable"
gem "cells"
gem "yajl-ruby"
gem "country-select"
gem "multiple_mailers"
gem "wmd-rails"

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'compass'
end

gem 'jquery-rails'

group :production do
  gem 'therubyracer'
end

group :development do
  gem 'thin'
  gem 'sqlite3-ruby', :require => 'sqlite3'
  gem "awesome_print", :require => 'ap'
  gem "bullet"
  gem "annotate"
  gem "rails-erd"
  gem "debugger"
  gem "quiet_assets"
  gem 'rack-perftools_profiler', :require => 'rack/perftools_profiler'

  gem "capistrano"
  gem "capistrano_colors"
  gem "capistrano-ext"

  gem "guard"
  gem "rb-inotify", :require => false
  gem "rb-fsevent", :require => false
  gem "rb-fchange", :require => false
  gem "guard-annotate"
  gem "guard-bundler"
  gem "guard-livereload"
  gem "guard-rails"
  gem "guard-migrate"
end

group :test do
  gem "simplecov", :require => false
  gem "spork", "1.0.0.rc2"
  gem "rspec"
  gem "rspec-rails"
  gem "factory_girl"
  gem "factory_girl_rails"
  gem 'shoulda-matchers'
  gem "email_spec"
  gem "rspec-cells"
  gem "guard-spork"
  gem "guard-rspec"
  gem "rails_best_practices", :git => "git://github.com/railsbp/rails_best_practices.git"
end

group :cucumber do
  gem "cucumber"
  gem "cucumber-rails"
  gem "capybara"
  gem "database_cleaner"
  gem "launchy"
  gem "pickle"
end
