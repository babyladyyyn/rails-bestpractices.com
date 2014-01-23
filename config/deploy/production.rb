set :stage, :production
set :rails_env, :production

role :app, %w{deploy@app.rails-bestpractices.com}
role :web, %w{deploy@app.rails-bestpractices.com}
role :db,  %w{deploy@db.rails-bestpractices.com}, primary: true

server 'app.rails-bestpractices.com', user: 'deploy', roles: %w{web app}
server 'db.rails-bestpractices.com', user: 'deploy', roles: %w{db}
