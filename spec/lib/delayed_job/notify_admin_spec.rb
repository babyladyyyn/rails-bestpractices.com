require "spec_helper"

describe DelayedJob::NotifyAdmin do

  it "should notify to admin" do
    post = FactoryGirl.create(:post)

    allow(mailer).to receive(:deliver)
    expect(NotificationMailer).to receive(:notify_admin).with(post).and_return(mailer)
    DelayedJob::NotifyAdmin.new(post.id).perform
  end
end
