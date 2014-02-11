set :bundle_roles, :all
set :rvm_type, :user
set :rvm_ruby_version, '2.0.0-p353'

set :application, "rails-bestpractices"
set :repo_url,  "git@github.com:railsbp/rails-bestpractices.com.git"
set :deploy_to, "/home/deploy/sites/rails-bestpractices.com/production"
set :scm, :git
set :branch, "master"

set :log_level, :debug

set :linked_files, %w{
  config/bitly.yml config/database.yml config/mailers.yml config/memcache.yml config/omniauth.yml config/redis.yml config/thinking_sphinx.yml config/initializers/secret_token.rb
  public/google9df66a0aeacea061.html public/BingSiteAuth.xml
}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system db/sphinx}

set :keep_releases, 5

namespace :deploy do

  after :finishing, 'deploy:cleanup'

end
