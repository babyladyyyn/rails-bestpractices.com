class NotificationMailer < ActionMailer::Base
  default :from => "notifications@rails-bestpractices.com"

  def notify_comment(email, comment)
    @comment = comment
    mail(:to => email, 
         :subject => "Comment on #{comment.parent_name}")
  end
end
