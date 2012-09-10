after "deploy:symlink", "deploy:update_crontab:db", "deploy:update_crontab:app"

namespace :deploy do
  namespace :update_crontab do
    desc "Update the crontab file on db server"
    task :db, :roles => :db do
      run "cd #{release_path} && bundle exec whenever --update-crontab -f config/schedule/db.rb -i rails-bestpractices.com-db"
    end

    desc "Update the crontab file on app server"
    task :app, :roles => :app do
      run "cd #{release_path} && bundle exec whenever --update-crontab -f config/schedule/app.rb -i rails-bestpractices.com-app"
    end
  end
end
