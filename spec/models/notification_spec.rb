require 'spec_helper'

describe Notification do

  include RailsBestPractices::Spec::Support

  it { should belong_to(:notifierable) }

  describe "notification count" do
    it "should increase notification count" do
      answer = FactoryGirl.create(:answer)
      user = answer.question.user
      expect {
        user.notifications.create(:notifierable => answer)
        user.reload
      }.to change(user, :unread_notification_count).by(1)
      expect {
        user.notifications.create(:notifierable => answer)
        user.reload
      }.to change(user, :unread_notification_count).by(1)
    end

    it "should decrease notification count when read" do
      answer = FactoryGirl.create(:answer)
      user = answer.question.user
      notification1 = user.notifications.create(:notifierable => answer)
      notification2 = user.notifications.create(:notifierable => answer)
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
      answer = FactoryGirl.create(:answer)
      user = answer.question.user
      notification1 = user.notifications.create(:notifierable => answer)
      notification2 = user.notifications.create(:notifierable => answer)
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
      answer = FactoryGirl.create(:answer)
      user = answer.question.user
      notification1 = user.notifications.create(:notifierable => answer)
      notification2 = user.notifications.create(:notifierable => answer)
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
