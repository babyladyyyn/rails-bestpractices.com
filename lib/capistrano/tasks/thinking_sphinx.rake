namespace :thinking_sphinx do
  desc "restart thinking_sphinx"
  task :restart do
    on roles(:app) do
      execute "sudo monit restart searchd.rails-bestpractices.com"
    end
  end
  after 'deploy:finished', 'thinking_sphinx:restart'
end
