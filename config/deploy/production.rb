set :rails_env, :production
set :deploy_to, "/home/huangzhi/sites/rails-bestpractices.com/production"

after "deploy:update_code", "env:init"
after "deploy:symlink", "deploy:update_crontab"

after "deploy:symlink", "delayed_job:restart"

after "deploy:update_code", "thinking_sphinx:symlink_sphinx_indexes"
after "deploy:symlink", "thinking_sphinx:restart"

namespace :env do
  task :init do
    run "cd #{release_path}; rake RAILS_ENV=#{rails_env} -s sitemap:refresh:no_ping"
    run "ln -nfs #{shared_path}/public/google9df66a0aeacea061.html #{release_path}/public/google9df66a0aeacea061.html"
    run "ln -nfs #{shared_path}/public/BingSiteAuth.xml #{release_path}/public/BingSiteAuth.xml"
  end
end

namespace :deploy do
  desc "Update the crontab file"
  task :update_crontab do
    run "cd #{release_path} && bundle exec whenever --update-crontab #{application}"
  end
end

namespace :delayed_job do
  desc "restart delayed job"
  task :restart do
    run "sudo monit restart delayed_job"
  end
end

namespace :thinking_sphinx do
  task :symlink_sphinx_indexes do
    run "ln -nfs #{shared_path}/db/sphinx #{release_path}/db/sphinx"
  end

  desc "restart thinking_sphinx"
  task :restart do
    run "sudo monit restart searchd"
  end
end
