require "spec_helper"

describe DelayedJob::NotifyAnswer do

  it "should notify to question user" do
    user = Factory(:user, :email => 'question@gmail.com')
    question = Factory(:question, :user => user)
    answer = Factory(:answer, :question => question)

    mailer.stub!(:deliver)
    NotificationMailer.should_receive(:notify_answer).with('question@gmail.com', answer).and_return(mailer)
    DelayedJob::NotifyAnswer.new(answer.id).perform
  end

  it "should not notify to question user when question user has no email" do
    user = Factory(:user, :email => '', :access_token => AccessToken.new)
    question = Factory(:question, :user => user)
    answer = Factory(:answer, :question => question)

    mailer.stub!(:deliver)
    DelayedJob::NotifyAnswer.new(answer.id).perform
  end

  it "should notify to question and answers user" do
    question_user = Factory(:user, :email => 'question@gmail.com')
    question = Factory(:question, :user => question_user)
    answer_user1 = Factory(:user, :email => 'answer1@gmail.com')
    answer1 = Factory(:answer, :question => question, :user => answer_user1, :body => 'answer1')
    answer_user2 = Factory(:user, :email => 'answer2@gmail.com')
    answer2 = Factory(:answer, :question => question, :user => answer_user2, :body => 'answer2')
    answer_user3 = Factory(:user, :email => 'answer3@gmail.com')
    answer3 = Factory(:answer, :question => question, :user => answer_user3, :body => 'answer3')

    answer = Factory(:answer, :question => question, :user => answer_user2, :body => 'answer')

    mailer.stub!(:deliver)
    NotificationMailer.should_receive(:notify_answer).with('question@gmail.com', answer).ordered.and_return(mailer)
    NotificationMailer.should_receive(:notify_answer).with('answer1@gmail.com', answer).ordered.and_return(mailer)
    NotificationMailer.should_receive(:notify_answer).with('answer3@gmail.com', answer).ordered.and_return(mailer)
    DelayedJob::NotifyAnswer.new(answer.id).perform
  end
end
