class NotificationMailer < ActionMailer::Base
  default :from => "notifications@rails-bestpractices.com"

  def notify_comment(email, comment)
    @comment = comment
    mail(:to => email, 
         :subject => "Comment on #{comment.parent_name}")
  end

  def notify_answer(email, answer)
    @answer = answer
    mail(:to => email,
         :subject => "Answer to #{answer.question.title}")
  end
end
