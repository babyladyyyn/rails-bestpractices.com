require "spec_helper"

describe DelayedJob::NotifyAnswer do

  it "should notify to question user" do
    user = FactoryGirl.create(:user, :email => 'question@gmail.com')
    question = FactoryGirl.create(:question, :user => user)
    answer = FactoryGirl.create(:answer, :question => question)

    allow(mailer).to receive(:deliver)
    expect(NotificationMailer).to receive(:notify_answer).with('question@gmail.com', answer).and_return(mailer)
    DelayedJob::NotifyAnswer.new(answer.id).perform
  end

  it "should not notify to question user when question user has no email" do
    user = FactoryGirl.create(:user)
    user.email = ''
    question = FactoryGirl.create(:question, :user => user)
    answer = FactoryGirl.create(:answer, :question => question)

    allow(mailer).to receive(:deliver)
    DelayedJob::NotifyAnswer.new(answer.id).perform
  end

  it "should notify to question and answers user" do
    question_user = FactoryGirl.create(:user, :email => 'question@gmail.com')
    question = FactoryGirl.create(:question, :user => question_user)
    answer_user1 = FactoryGirl.create(:user, :email => 'answer1@gmail.com')
    answer1 = FactoryGirl.create(:answer, :question => question, :user => answer_user1, :answer_body => AnswerBody.new(:body => 'answer1'))
    answer_user2 = FactoryGirl.create(:user, :email => 'answer2@gmail.com')
    answer2 = FactoryGirl.create(:answer, :question => question, :user => answer_user2, :answer_body => AnswerBody.new(:body => 'answer2'))
    answer_user3 = FactoryGirl.create(:user, :email => 'answer3@gmail.com')
    answer3 = FactoryGirl.create(:answer, :question => question, :user => answer_user3, :answer_body => AnswerBody.new(:body => 'answer3'))

    answer = FactoryGirl.create(:answer, :question => question, :user => answer_user2, :answer_body => AnswerBody.new(:body => 'answer'))

    allow(mailer).to receive(:deliver)
    expect(NotificationMailer).to receive(:notify_answer).with('question@gmail.com', answer).ordered.and_return(mailer)
    expect(NotificationMailer).to receive(:notify_answer).with('answer1@gmail.com', answer).ordered.and_return(mailer)
    expect(NotificationMailer).to receive(:notify_answer).with('answer3@gmail.com', answer).ordered.and_return(mailer)
    DelayedJob::NotifyAnswer.new(answer.id).perform
  end
end
