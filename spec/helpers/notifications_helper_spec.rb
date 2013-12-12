require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe NotificationsHelper do
  describe "should notification message" do
    it "should display for answer" do
      question_user = FactoryGirl.create(:user, :login => 'question_user')
      question = FactoryGirl.create(:question, :title => 'notifierable question', :user => question_user)
      answer_user = FactoryGirl.create(:user, :login => 'answer_user')
      answer = FactoryGirl.create(:answer, :question => question, :user => answer_user)
      notification = FactoryGirl.create(:notification, :notifierable => answer, :user => question_user)

      expect(helper.notification_message(notification)).to eq("#{link_to 'answer_user', user_path(answer_user)} answered on Question #{link_to 'notifierable question', question_path(question)}")
    end
  end
end
