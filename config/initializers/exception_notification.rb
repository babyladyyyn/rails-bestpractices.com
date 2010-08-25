# this will be overridden on server
RailsBestpracticesCom::Application.configure do
  config.middleware.use ExceptionNotifier,
    :email_prefix => "[rails-bestpractices.com] ",
    :sender_address => %{"Application Error" <exception.notifier@rails-bestpractices.com>},
    :exception_recipients => %w(flyerhzm@rails-bestpractices.com)
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
  }
end