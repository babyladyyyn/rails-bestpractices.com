after "deploy:update_code", "sitemap:refresh"

namespace :sitemap do
  task :refresh, :roles => :app do
    run "ln -nfs #{shared_path}/public/google9df66a0aeacea061.html #{release_path}/public/google9df66a0aeacea061.html"
    run "ln -nfs #{shared_path}/public/BingSiteAuth.xml #{release_path}/public/BingSiteAuth.xml"
    run "cd #{release_path}; #{rake} RAILS_ENV=#{rails_env} -s sitemap:refresh:no_ping"
  end
end
