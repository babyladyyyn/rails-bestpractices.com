SwitchUser.setup do |config|
  config.provider = :authlogic
  config.available_users = { :user => lambda { User.all } }
  config.controller_guard = lambda { |current_user, request| Rails.env == "development" }
  config.view_guard = lambda { |current_user, request| Rails.env == "development" && (!current_user or current_user.email != "flyerhzm@gmail.com") }
  config.redirect_path = lambda { '/' }
end
