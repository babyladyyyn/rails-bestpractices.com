ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'email_spec'
require 'database_cleaner'
require 'coveralls'
Coveralls.wear!('rails')

require 'support'
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

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
