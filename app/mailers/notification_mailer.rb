class NotificationMailer < ActionMailer::Base
  default :from => "notifications@rails-bestpractices.com"

  def notify_comment(commentable, user_id)
    mail(:to => notification.notifier_user.email, :subject => "Comment on #{}")
  end
end
