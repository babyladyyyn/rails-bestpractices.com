environment 'production'
daemonize
pidfile '/home/huangzhi/sites/rails-bestpractices.com/production/shared/tmp/pids/puma.pid'
state_path '/home/huangzhi/sites/rails-bestpractices.com/production/shared/tmp/sockets/puma.state'
stdout_redirect '/home/huangzhi/sites/rails-bestpractices.com/production/shared/log/stdout.log', '/home/huangzhi/sites/rails-bestpractices.com/production/shared/log/stderr.log'
threads 4, 16
workers 2
bind 'unix:///home/huangzhi/sites/rails-bestpractices.com/production/shared/tmp/sockets/puma.sock'
activate_control_app 'unix:///home/huangzhi/sites/rails-bestpractices.com/production/shared/tmp/sockets/pumactl.sock'
preload_app!

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end
