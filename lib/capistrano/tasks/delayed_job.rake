namespace :delayed_job do
  task :restart do
    on roles(:db) do
      execute "sudo monit restart delayed_job.rails-bestpractices.com"
    end
  end
  after "deploy:finished", "delayed_job:restart"
end
