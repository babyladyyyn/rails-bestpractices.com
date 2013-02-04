before "deploy:finalize_update", "deploy:update_shared_configs"

namespace :deploy do
  task :update_shared_configs do
    run "ln -nfs #{shared_path}/config/*.yml #{release_path}/config/"
    run "ln -nfs #{shared_path}/config/initializers/secret_token.rb #{release_path}/config/initializers/secret_token.rb"
  end
end
