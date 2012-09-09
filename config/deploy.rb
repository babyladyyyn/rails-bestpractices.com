set :stages, %w(staging production)
set :default_stage, "staging"
require 'capistrano/ext/multistage'
require 'capistrano_colors'
require 'bundler/capistrano'
require 'thinking_sphinx/deploy/capistrano'

require 'rvm/capistrano'
set :rvm_ruby_string, 'ruby-1.9.3-p194@rails-bestpractices.com'
set :rvm_type, :user

set :application, "rails-bestpractices"
set :repository,  "git@github.com:railsbp/rails-bestpractices.com.git"

set :scm, :git
set :user, 'huangzhi'

set :rake, "bundle exec rake"

role :web, "app.rails-bestpractices.com"
role :app, "app.rails-bestpractices.com"
role :db,  "db.rails-bestpractices.com", :primary => true

load "config/deploy/asset_pipeline"
load "config/deploy/shared_symbolic"
load "config/deploy/css_sprite"

after "deploy:update_code", "asset:revision"

namespace :asset do
  task :revision, :roles => :app do
    run "cd #{release_path}; git ls-remote origin master | awk '{print $1}' > #{release_path}/public/REVISION"
  end
end

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    migrate
    cleanup
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
