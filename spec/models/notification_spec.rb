require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe Notification do

  include RailsBestPractices::Spec::Support
  
  should_have_entries_per_page 10
  should_belong_to :notifierable, :polymorphic => true

  describe "notification count" do
    it "should increase notification count" do
      comment = Factory(:comment)
      user = comment.user
      user.notifications.create(:notifierable => comment)
      user.unread_notification_count.should == 1
      user.notifications.create(:notifierable => comment)
      user.unread_notification_count.should == 2
    end

    it "should decrease notification count when read" do
      comment = Factory(:comment)
      user = comment.user
      notification1 = user.notifications.create(:notifierable => comment)
      notification2 = user.notifications.create(:notifierable => comment)
      notification1.read!
      user.unread_notification_count.should == 1
      notification2.read!
      user.unread_notification_count.should == 0
    end

    it "should decrease notification count before destroy" do
      comment = Factory(:comment)
      user = comment.user
      notification1 = user.notifications.create(:notifierable => comment)
      notification2 = user.notifications.create(:notifierable => comment)
      notification1.destroy
      user.unread_notification_count.should == 1
      notification2.destroy
      user.unread_notification_count.should == 0
    end

    it "should not decrease notification count when delete after read" do
      comment = Factory(:comment)
      user = comment.user
      notification1 = user.notifications.create(:notifierable => comment)
      notification2 = user.notifications.create(:notifierable => comment)
      notification1.read!
      user.unread_notification_count.should == 1
      notification1.destroy
      user.unread_notification_count.should == 1
    end
  end

end
