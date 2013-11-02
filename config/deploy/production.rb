set :stage, :production
set :rails_env, :production

role :app, %w{huangzhi@app.rails-bestpractices.com}
role :web, %w{huangzhi@app.rails-bestpractices.com}
role :db,  %w{huangzhi@db.rails-bestpractices.com}, primary: true

server 'app.rails-bestpractices.com', user: 'huangzhi', roles: %w{web app}
server 'db.rails-bestpractices.com', user: 'huangzhi', roles: %w{db}
