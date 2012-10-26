require "spec_helper"

describe NotificationMailer do
  describe "notify_answer" do
    before :each do
      @question = Factory(:question, :title => 'email question')
      @answer = Factory(:answer, :question => @question, :answer_body => AnswerBody.new(:body => 'answer body'))
      @user = Factory(:user, :email => 'flyerhzm@gmail.com')
    end
    subject { NotificationMailer.notify_answer("flyerhzm@gmail.com", @answer) }

    it { should deliver_to("flyerhzm@gmail.com") }
    it { should have_subject(/Answer to email question/) }
    it { should have_body_text(/answer body/) }
    it { should have_body_text(/#{question_url(@question)}/) }
    it { should have_body_text(/If you don't want to receive email notification, please unsubscribe it/) }
    it { should have_body_text(/#{edit_user_registration_url}/) }
  end

  describe "notify_admin" do
    before { @post = Factory(:post) }
    subject { NotificationMailer.notify_admin(@post) }

    it { should deliver_to("flyerhzm@gmail.com") }
    it { should have_subject(/post a best practice/) }
    it { should have_body_text(/post a best practice/) }
    it { should have_body_text(/#{post_url(@post)}/) }
  end

  describe "notify_job" do
    before { @job = Factory(:job) }
    subject { NotificationMailer.notify_job(@job) }

    it { should deliver_to("flyerhzm@gmail.com") }
    it { should have_subject(/post a job/) }
    it { should have_body_text(/post a job/) }
    it { should have_body_text(/#{job_url(@job)}/) }
  end
end
