namespace :deploy do
  namespace :update_crontab do
    desc "Update the crontab file on db server"
    task :db do
      on roles(:db) do
        within release_path do
          execute :bundle, "exec whenever --update-crontab -f config/schedule/db.rb -i rails-bestpractices.com-db"
        end
      end
    end
    after :published, 'deploy:update_crontab:db'

    desc "Update the crontab file on app server"
    task :app do
      on roles(:app) do
        within release_path do
          execute :bundle, "exec whenever --update-crontab -f config/schedule/app.rb -i rails-bestpractices.com-app"
        end
      end
    end
    after :published, 'deploy:update_crontab:app'
  end
end
