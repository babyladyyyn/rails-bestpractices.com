require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require "email_spec"
  require "database_cleaner"
  DatabaseCleaner.strategy = :truncation

  Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

  Devise.stretches = 1
  Rails.logger.level = 4

  RSpec.configure do |config|
    config.mock_with :rspec

    config.use_transactional_fixtures = true

    config.filter_run :focus => true
    config.run_all_when_everything_filtered = true

    config.include(EmailSpec::Helpers)
    config.include(EmailSpec::Matchers)

    config.before do
      DatabaseCleaner.clean
    end

    config.after do
      Rails.cache.clear
    end
  end
end

Spork.each_run do
  require 'factory_girl_rails'
  require File.join(File.dirname(__FILE__), 'support')
end
