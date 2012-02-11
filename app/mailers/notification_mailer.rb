class NotificationMailer < ActionMailer::Base
  include Devise::Controllers::ScopedViews

  if Rails.env.production?
    class <<self
      def smtp_settings
        options = YAML.load_file("#{Rails.root}/config/mailers.yml")[Rails.env]['notification']
        @@smtp_settings = {
          :address              => options["address"],
          :port                 => options["port"],
          :domain               => options["domain"],
          :authentication       => options["authentication"],
          :user_name            => options["user_name"],
          :password             => options["password"]
        }
      end
    end
  end

  default :from => "notification@rails-bestpractices.com"

  def notify_comment(email, comment)
    @comment = comment
    @user = User.find_cached_by_email(email)
    mail(:to => email,
         :subject => "Comment on #{@comment.parent_name}")
  end

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
