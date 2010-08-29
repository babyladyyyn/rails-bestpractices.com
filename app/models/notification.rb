class Notification < ActiveRecord::Base

  belongs_to :notifierable, :polymorphic => true
  belongs_to :user

  after_create :increase_notification_count
  before_destroy :decrease_notification_count

  default_scope order('created_at desc')

  def self.per_page
    10
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
      if notifierable.is_a? Comment
        notifierable.commentable.user
      elsif notifierable.is_a? Answer
        notifierable.question.user
      end
    end
end
