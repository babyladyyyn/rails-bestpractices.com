require 'capistrano/setup'
require 'capistrano/deploy'

require 'capistrano/rvm'
require 'capistrano/bundler'
require 'capistrano/puma'
require 'capistrano/rails'
require 'sidekiq/capistrano'

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| load r }
