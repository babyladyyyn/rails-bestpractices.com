require 'spec_helper'

describe NotificationSetting do
  should_belong_to :user

  describe "description" do
    it "should get global email description" do
      Factory(:notification_setting, :name => 'global_email').description.should == 'Receive email notification (global setting)'
    end

    it "should get comment post description" do
      Factory(:notification_setting, :name => 'comment_post').description.should == 'Comment on my Rails Best Practice'
    end
  end
end
