SwitchUser.setup do |config|
  config.provider = :devise
  config.available_users = { :user => lambda { User.all } }
  config.redirect_path = lambda { |request, params| '/' }
end
