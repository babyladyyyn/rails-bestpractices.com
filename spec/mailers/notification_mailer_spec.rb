require "spec_helper"

describe NotificationMailer do
  describe "notify_comment" do
    before :each do
      @post = Factory(:post, :title => 'email post')
      @comment = Factory(:comment, :commentable => @post, :body => 'comment body')
      @email = NotificationMailer.notify_comment("flyerhzm@gmail.com", @comment)
    end

    it "should be set to be delivered to the email passed in" do
      @email.should deliver_to("flyerhzm@gmail.com")
    end

    it "should have the correct subject" do
      @email.should have_subject(/Comment on Post email post/)
    end

    it "should contain the comment's body in the mail body" do
      @email.should have_body_text(/comment body/)
    end

    it "should contain a link to the post" do
      @email.should have_body_text(/#{post_url(@post)}/)
    end
  end
end
