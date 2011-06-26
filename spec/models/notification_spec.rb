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

require 'spec_helper'

describe Notification do

  include RailsBestPractices::Spec::Support

  should_have_entries_per_page 10
  should_belong_to :notifierable, :polymorphic => true

  describe "notification count" do
    it "should increase notification count" do
      comment = Factory(:comment)
      user = comment.commentable.user
      expect {
        user.notifications.create(:notifierable => comment)
      }.to change(user, :unread_notification_count).by(1)
      expect {
        user.notifications.create(:notifierable => comment)
      }.to change(user, :unread_notification_count).by(1)
    end

    it "should decrease notification count when read" do
      comment = Factory(:comment)
      user = comment.commentable.user
      notification1 = user.notifications.create(:notifierable => comment)
      notification2 = user.notifications.create(:notifierable => comment)
      expect {
        notification1.read!
      }.to change(user, :unread_notification_count).by(-1)
      expect {
        notification2.read!
      }.to change(user, :unread_notification_count).by(-1)
    end

    it "should decrease notification count before destroy" do
      comment = Factory(:comment)
      user = comment.commentable.user
      notification1 = user.notifications.create(:notifierable => comment)
      notification2 = user.notifications.create(:notifierable => comment)
      expect {
        notification1.destroy
      }.to change(user, :unread_notification_count).by(-1)
      expect {
        notification2.destroy
      }.to change(user, :unread_notification_count).by(-1)
    end

    it "should not decrease notification count when delete after read" do
      comment = Factory(:comment)
      user = comment.commentable.user
      notification1 = user.notifications.create(:notifierable => comment)
      notification2 = user.notifications.create(:notifierable => comment)
      expect {
        notification1.read!
      }.to change(user, :unread_notification_count).by(-1)
      expect {
        notification1.destroy
      }.to change(user, :unread_notification_count).by(0)
    end
  end

end

