class Notification < ActiveRecord::Base

  belongs_to :notifierable, :polymorphic => true
  belongs_to :user

  after_create :increase_notification_count
  before_destroy :decrease_notification_count

  def self.per_page
    10
  end

  def read!
    decrease_notification_count
    self.update_attribute(:read, true)
  end

  private

    def increase_notification_count
      notifierable.user.increment! :unread_notification_count
    end

    def decrease_notification_count
      unless self.read?
        notifierable.user.decrement! :unread_notification_count
      end
    end
end
