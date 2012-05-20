ContactUs.setup do |config|
  config.mailer_from = "notification@rails-bestpractices.com"
  config.mailer_to = "contact-us@rails-bestpractices.com"
  config.require_name = true
  config.require_subject = true
  config.form_gem = "formtastic"
end
