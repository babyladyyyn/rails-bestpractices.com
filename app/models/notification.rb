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

  belongs_to :notifierable, :polymorphic => true
  belongs_to :user

  after_create :increase_notification_count
  before_destroy :decrease_notification_count

  default_scope order('notifications.created_at desc')

  paginates_per 10

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
      if notifierable.is_a? Comment
        notifierable.commentable.user
      elsif notifierable.is_a? Answer
        notifierable.question.user
      end
    end
end

