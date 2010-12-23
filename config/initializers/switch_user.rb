SwitchUser.setup do |config|
  config.provider = :authlogic
  config.available_users = { :user => lambda { User.all } }
  config.redirect_path = lambda { |request, params| '/' }
end
