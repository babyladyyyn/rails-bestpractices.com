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

  paginates_per 10

  model_cache do
    with_method :notifierable
  end

  def read!
    decrease_notification_count
    self.update_attribute(:read, true)
  end

  private

    def increase_notification_count
      notify_user.increment! :unread_notification_count
    end

    def decrease_notification_count
      unless self.read?
        notify_user.decrement! :unread_notification_count
      end
    end

    def notify_user
      if cached_notifierable.is_a? Comment
        cached_notifierable.cached_commentable.cached_user
      elsif cached_notifierable.is_a? Answer
        cached_notifierable.cached_question.cached_user
      end
    end
end

