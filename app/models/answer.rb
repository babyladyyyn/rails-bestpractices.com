# == Schema Information
#
# Table name: answers
#
#  id             :integer(4)      not null, primary key
#  user_id        :integer(4)
#  vote_points    :integer(4)      default(0)
#  question_id    :integer(4)
#  created_at     :datetime
#  updated_at     :datetime
#  comments_count :integer(4)      default(0)
#

class Answer < ActiveRecord::Base

  include ActiveModel::ForbiddenAttributesProtection
  include UserOwnable
  include Voteable
  include Cacheable

  belongs_to :question, :counter_cache => true
  has_one :answer_body, :dependent => :destroy

  accepts_nested_attributes_for :answer_body

  delegate :body, :formatted_html, :to => :answer_body

  after_create :expire_question_and_user_cache, :notify_user
  after_destroy :expire_question_and_user_cache, :destroy_notification

  model_cache do
    with_key
    with_method :formatted_html
    with_association :user, :question
  end

  def tweet_title
    "Answer for #{cached_question.title}"
  end

  def tweet_path
    "questions/#{cached_question.to_param}"
  end

  private
    def expire_question_and_user_cache
      question.expire_model_cache
      user.expire_model_cache
    end

    def notify_user
      if self.question.user != self.user
        self.question.user.notifications.create(:notifierable => self)
      end
    end

    def destroy_notification
      Notification.where(:notifierable_id => self.id, :notifierable_type => "Answer").destroy_all
    end
end

