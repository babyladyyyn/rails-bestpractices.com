set :stage, :production
set :rails_env, :production

role :app, %w{deploy@app.rails-bestpractices.com}
role :web, %w{deploy@app.rails-bestpractices.com}
role :db,  %w{deploy@db.rails-bestpractices.com}, primary: true

server 'app.rails-bestpractices.com', user: 'deploy', roles: %w{web app}
server 'db.rails-bestpractices.com', user: 'deploy', roles: %w{db}

set :sidekiq_role, :sidekiq
role :sidekiq, 'deploy@db.rails-bestpractices.com'

set(:sidekiq_cmd) { "#{bundle_cmd} exec sidekiq" }
set(:sidekiqctl_cmd) { "#{bundle_cmd} exec sidekiqctl" }
set(:sidekiq_timeout) { 10 }
set(:sidekiq_role) { :deploy }
set(:sidekiq_pid) { "#{current_path}/tmp/pids/sidekiq.pid" }
set(:sidekiq_processes) { 1 }
