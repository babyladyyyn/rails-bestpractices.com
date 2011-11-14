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
        user.reload
      }.to change(user, :unread_notification_count).by(1)
      expect {
        user.notifications.create(:notifierable => comment)
        user.reload
      }.to change(user, :unread_notification_count).by(1)
    end

    it "should decrease notification count when read" do
      comment = Factory(:comment)
      user = comment.commentable.user
      notification1 = user.notifications.create(:notifierable => comment)
      notification2 = user.notifications.create(:notifierable => comment)
      user.reload
      expect {
        notification1.read!
        user.reload
      }.to change(user, :unread_notification_count).by(-1)
      expect {
        notification2.read!
        user.reload
      }.to change(user, :unread_notification_count).by(-1)
    end

    it "should decrease notification count before destroy" do
      comment = Factory(:comment)
      user = comment.commentable.user
      notification1 = user.notifications.create(:notifierable => comment)
      notification2 = user.notifications.create(:notifierable => comment)
      user.reload
      expect {
        notification1.destroy
        user.reload
      }.to change(user, :unread_notification_count).by(-1)
      expect {
        notification2.destroy
        user.reload
      }.to change(user, :unread_notification_count).by(-1)
    end

    it "should not decrease notification count when delete after read" do
      comment = Factory(:comment)
      user = comment.commentable.user
      notification1 = user.notifications.create(:notifierable => comment)
      notification2 = user.notifications.create(:notifierable => comment)
      user.reload
      expect {
        notification1.read!
        user.reload
      }.to change(user, :unread_notification_count).by(-1)
      expect {
        notification1.destroy
        user.reload
      }.to change(user, :unread_notification_count).by(0)
    end
  end

end

