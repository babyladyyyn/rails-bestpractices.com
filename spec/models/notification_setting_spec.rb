# == Schema Information
#
# Table name: notification_settings
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  value      :boolean(1)      default(TRUE)
#  user_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

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

