class NotificationMailer < ActionMailer::Base
  if Rails.env.production?
    class <<self
      def smtp_settings
        options = YAML.load_file("#{RAILS_ROOT}/config/mailers.yml")[Rails.env]['notification']
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
    @user = User.find_by_email(email)
    mail(:to => email,
         :subject => "Comment on #{comment.parent_name}")
  end

  def notify_answer(email, answer)
    @answer = answer
    @user = User.find_by_email(email)
    mail(:to => email,
         :subject => "Answer to #{answer.question.title}")
  end
end
