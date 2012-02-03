# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
set :output, "/home/huangzhi/sites/rails-bestpractices.com/production/shared/log/cron_log.log"
job_type :rake, "cd :path && RAILS_ENV=:environment bundle exec rake :task :output"

every 1.day, :at => '2am' do
  rake "sitemap:refresh"
end
