require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe NotificationsHelper do
  describe "should notification message" do
    before :each do
      helper.extend(CommentsHelper)
    end

    it "should display for comment" do
      post_user = Factory(:user, :login => 'post_user')
      post = Factory(:post, :title => 'notifierable post', :user => post_user)
      comment_user = Factory(:user, :login => 'comment_user')
      comment = Factory(:comment, :commentable => post, :user => comment_user)
      notification = Factory(:notification, :notifierable => comment, :user => post_user)

      helper.notification_message(notification).should == "#{link_to 'comment_user', user_path(comment_user)} commented on #{link_to "Post #{post.title}", post_url(post)}"
    end

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
