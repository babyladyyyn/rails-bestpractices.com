before "deploy:finalize_update", "thinking_sphinx:symlink_sphinx_configs", "thinking_sphinx:symlink_sphinx_indexes"
after "deploy:create_symlink", "thinking_sphinx:restart"

namespace :thinking_sphinx do
  task :symlink_sphinx_configs, :roles => :app do
    run "ln -nfs #{shared_path}/config/sphinx.yml #{release_path}/config/sphinx.yml"
  end

  task :symlink_sphinx_indexes, :roles => :app do
    run "ln -nfs #{shared_path}/db/sphinx #{release_path}/db/sphinx"
  end

  desc "restart thinking_sphinx"
  task :restart, :roles => :app do
    run "cd #{current_path}; #{rake} RAILS_ENV=#{rails_env} ts:configure ts:rebuild"
  end
end
