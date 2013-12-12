require 'spec_helper'

describe NotificationSetting do
  it { should belong_to(:user) }

  describe "description" do
    it "should get global email description" do
      expect(FactoryGirl.create(:notification_setting, :name => 'global_email').description).to eq('Receive email notification (global setting)')
    end

    it "should get question answer description" do
      expect(FactoryGirl.create(:notification_setting, :name => 'answer_question').description).to eq('Answer on my Question')
    end
  end
end
