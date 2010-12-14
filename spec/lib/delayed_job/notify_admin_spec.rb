require "spec_helper"

describe DelayedJob::NotifyAdmin do

  it "should notify to admin" do
    post = Factory(:post)

    mailer.stub!(:deliver)
    NotificationMailer.should_receive(:notify_admin).with(post).and_return(mailer)
    DelayedJob::NotifyAdmin.new(post.id).perform
  end
end
