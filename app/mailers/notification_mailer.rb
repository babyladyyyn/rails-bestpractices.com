class NotificationMailer < ActionMailer::Base
  include Devise::Controllers::ScopedViews

  mailer_account "notification"

  default :from => "notification@rails-bestpractices.com"

  def notify_answer(email, answer)
    @answer = answer
    @user = User.find_cached_by_email(email)
    mail(:to => email,
         :subject => "Answer to #{answer.cached_question.title}")
  end

  def notify_admin(post)
    @post = post
    @user = post.cached_user
    mail(:to => 'flyerhzm@gmail.com',
         :subject => "#{@user.login} post a best practice")
  end

  def notify_job(job)
    @job = job
    @user = job.cached_user
    mail(:to => 'flyerhzm@gmail.com',
         :subject => "#{@user.try(:login)} post a job")
  end

  def reset_password_instructions(user)
    @resource = user
    mail(:to => user.email, :subject => "Reset password instructions")
  end
end
