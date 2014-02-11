require "spec_helper"

describe NotifyAdminWorker do

  it "should notify to admin" do
    post = FactoryGirl.create(:post)

    allow(mailer).to receive(:deliver)
    expect(NotificationMailer).to receive(:notify_admin).with(post).and_return(mailer)
    NotifyAdminWorker.new.perform(post.id)
  end
end
