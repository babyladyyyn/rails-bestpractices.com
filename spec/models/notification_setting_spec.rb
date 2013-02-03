require 'spec_helper'

describe NotificationSetting do
  it { should belong_to(:user) }

  describe "description" do
    it "should get global email description" do
      FactoryGirl.create(:notification_setting, :name => 'global_email').description.should == 'Receive email notification (global setting)'
    end

    it "should get question answer description" do
      FactoryGirl.create(:notification_setting, :name => 'answer_question').description.should == 'Answer on my Question'
    end
  end
end
