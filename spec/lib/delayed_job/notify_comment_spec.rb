require "spec_helper"

describe DelayedJob::NotifyComment do

  it "should notify to post user" do
    user = Factory(:user, :email => 'post@gmail.com')
    post = Factory(:post, :user => user)
    comment = Factory(:comment, :commentable => post)

    mailer.stub!(:deliver)
    NotificationMailer.should_receive(:notify_comment).with('post@gmail.com', comment).and_return(mailer)
    DelayedJob::NotifyComment.new(comment.id).perform
  end

  it "should not notify to post user when post user has no email" do
    user = Factory(:user, :email => '', :access_token => AccessToken.new)
    post = Factory(:post, :user => user)
    comment = Factory(:comment, :commentable => post)

    mailer.stub!(:deliver)
    DelayedJob::NotifyComment.new(comment.id).perform
  end

  it "should notify to post and comments user" do
    post_user = Factory(:user, :email => 'post@gmail.com')
    post = Factory(:post, :user => post_user)
    comment_user1 = Factory(:user, :email => 'comment1@gmail.com')
    comment1 = Factory(:comment, :commentable => post, :user => comment_user1, :body => 'comment1')
    comment2 = Factory(:comment, :commentable => post, :user => nil, :username => 'comment2', :email => 'comment2@gmail.com', :body => 'comment2')
    comment_user3 = Factory(:user, :email => 'comment3@gmail.com')
    comment3 = Factory(:comment, :commentable => post, :user => comment_user3, :body => 'comment3')

    comment = Factory(:comment, :commentable => post, :user => nil, :username => 'comment2', :email => 'comment2@gmail.com', :body => 'comment')

    mailer.stub!(:deliver)
    NotificationMailer.should_receive(:notify_comment).with('post@gmail.com', comment).ordered.and_return(mailer)
    NotificationMailer.should_receive(:notify_comment).with('comment1@gmail.com', comment).ordered.and_return(mailer)
    NotificationMailer.should_receive(:notify_comment).with('comment3@gmail.com', comment).ordered.and_return(mailer)
    DelayedJob::NotifyComment.new(comment.id).perform
  end
end
