# == Schema Information
#
# Table name: notifications
#
#  id                :integer(4)      not null, primary key
#  user_id           :integer(4)
#  notifierable_type :string(255)
#  notifierable_id   :integer(4)
#  read              :boolean(1)      default(FALSE)
#  created_at        :datetime
#  updated_at        :datetime
#

class Notification < ActiveRecord::Base
  include Cacheable

  belongs_to :notifierable, :polymorphic => true
  belongs_to :user

  after_create :increase_notification_count
  before_destroy :decrease_notification_count

  default_scope order('notifications.created_at desc')

  after_create :expire_notify_user_cache
  after_destroy :expire_notify_user_cache

  model_cache do
    with_method :notify_user
    with_association :notifierable
  end

  def read!
    decrease_notification_count
    self.update_attribute(:read, true)
  end

  private
    def increase_notification_count
      User.increment_counter(:unread_notification_count, cached_notify_user.id)
    end

    def decrease_notification_count
      unless self.read?
        User.decrement_counter(:unread_notification_count, cached_notify_user.id)
      end
    end

    def notify_user
      if notifierable.is_a? Comment
        notifierable.commentable.user
      elsif notifierable.is_a? Answer
        notifierable.question.user
      end
    end

    def expire_notify_user_cache
      notify_user.expire_model_cache
    end
end

