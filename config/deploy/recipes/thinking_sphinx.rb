require 'thinking_sphinx/deploy/capistrano'

before "deploy:finalize_update", "thinking_sphinx:symlink_sphinx_configs", "thinking_sphinx:symlink_sphinx_indexes"
after "deploy:symlink", "thinking_sphinx:restart"

namespace :thinking_sphinx do
  task :symlink_sphinx_configs do
    run "ln -nfs #{shared_path}/config/sphinx.yml #{release_path}/config/sphinx.yml"
    run "ln -nfs #{shared_path}/config/initializers/sphinx.rb #{release_path}/config/initializers/sphinx.rb"
  end

  task :symlink_sphinx_indexes, :roles => :db do
    run "ln -nfs #{shared_path}/db/sphinx #{release_path}/db/sphinx"
  end

  desc "restart thinking_sphinx"
  task :restart, :roles => :db do
    rake "thinking_sphinx:configure thinking_sphinx:stop thinking_sphinx:start"
  end
end
