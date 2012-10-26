require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe NotificationsHelper do
  describe "should notification message" do
    it "should display for answer" do
      question_user = Factory(:user, :login => 'question_user')
      question = Factory(:question, :title => 'notifierable question', :user => question_user)
      answer_user = Factory(:user, :login => 'answer_user')
      answer = Factory(:answer, :question => question, :user => answer_user)
      notification = Factory(:notification, :notifierable => answer, :user => question_user)

      helper.notification_message(notification).should == "#{link_to 'answer_user', user_path(answer_user)} answered on Question #{link_to 'notifierable question', question_path(question)}"
    end
  end
end
