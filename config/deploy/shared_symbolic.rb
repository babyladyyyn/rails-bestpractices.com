before "deploy:assets:precompile", "shared_symbolic:create"

namespace :shared_symbolic do
  task :create do
    run "ln -nfs #{shared_path}/config/bitly.yml #{release_path}/config/bitly.yml"
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/mailers.yml #{release_path}/config/mailers.yml"
    run "ln -nfs #{shared_path}/config/omniauth.yml #{release_path}/config/omniauth.yml"
    run "ln -nfs #{shared_path}/config/sphinx.yml #{release_path}/config/sphinx.yml"
    run "ln -nfs #{shared_path}/config/memcache.yml #{release_path}/config/memcache.yml"
    run "ln -nfs #{shared_path}/config/initializers/sphinx.rb #{release_path}/config/initializers/sphinx.rb"
  end
end
