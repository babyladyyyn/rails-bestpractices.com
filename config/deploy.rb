require 'capistrano_colors'
require 'bundler/capistrano'
require 'rvm/capistrano'
set :rvm_ruby_string, 'ruby-1.9.3-p194@rails-bestpractices.com'

set :application, "rails-bestpractices"
set :repository,  "git@github.com:railsbp/rails-bestpractices.com.git"
set :rails_env, "production"
set :deploy_to, "/home/huangzhi/sites/rails-bestpractices.com/production"

set :scm, :git
set :user, 'huangzhi'
set :git_shallow_clone, 1

role :web, "app.rails-bestpractices.com"
role :app, "app.rails-bestpractices.com"
role :db,  "db.rails-bestpractices.com", :primary => true

before "deploy:finalize_update", "asset:revision"

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
