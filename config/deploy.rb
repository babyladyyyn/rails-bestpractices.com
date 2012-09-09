require 'capistrano_colors'
require 'bundler/capistrano'
require 'rvm/capistrano'
set :rvm_ruby_string, 'ruby-1.9.3-p194@rails-bestpractices.com'

set :application, "rails-bestpractices"
set :repository,  "git@github.com:railsbp/rails-bestpractices.com.git"
set :rails_env, :production
set :deploy_to, "/home/huangzhi/sites/rails-bestpractices.com/production"

set :scm, :git
set :user, 'huangzhi'

set :rake, "bundle exec rake"

role :web, "app.rails-bestpractices.com"
role :app, "app.rails-bestpractices.com"
role :db,  "db.rails-bestpractices.com", :primary => true

load "config/deploy/asset_pipeline"
load "config/deploy/cron"
load "config/deploy/css_sprite"
load "config/deploy/delayed_job"
load "config/deploy/sitemap"
load "config/deploy/thinking_sphinx"

before "deploy:assets:precompile", "shared_symlink:create"
after "deploy:update_code", "asset:revision"

namespace :shared_symlink do
  task :create do
    run "ln -nfs #{shared_path}/config/bitly.yml #{release_path}/config/bitly.yml"
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/mailers.yml #{release_path}/config/mailers.yml"
    run "ln -nfs #{shared_path}/config/omniauth.yml #{release_path}/config/omniauth.yml"
    run "ln -nfs #{shared_path}/config/memcache.yml #{release_path}/config/memcache.yml"
  end
end

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
