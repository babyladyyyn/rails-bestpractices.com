after  "deploy:restart", "delayed_job:restart"

namespace :delayed_job do
  task :restart, :roles => :db do
    run "sudo monit restart delayed_job.rails-bestpractices.com"
  end
end
