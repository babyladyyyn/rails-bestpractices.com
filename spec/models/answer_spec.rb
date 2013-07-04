require 'spec_helper'

describe Answer do

  include RailsBestPractices::Spec::Support
  should_be_user_ownable
  should_be_voteable

  should_be_tweetable do |answer|
    {
      :title => "Answer for #{answer.question.title}",
      :path => "questions/#{answer.question.to_param}"
    }
  end

  it { should belong_to(:question) }

  describe "notify_user" do
    it "creates a notification after creating a question answer" do
      question = FactoryGirl.create(:question)
      expect {
        FactoryGirl.create(:answer, question: question)
      }.to change(Notification, :count).by(1)
    end

    it "doesn't create a notification after creating a question answer if answer user is same to question user" do
      question = FactoryGirl.create(:question)
      expect {
        FactoryGirl.create(:answer, question: question, user: question.user)
      }.not_to change(Notification, :count)
    end
  end

  describe "destroy_notification" do
    let(:user) { FactoryGirl.create(:user) }

    it "destroys the notification after destroying an answer" do
      answer = FactoryGirl.create :answer, user: user
      expect {
        answer.destroy
      }.to change(Notification, :count).by(-1)
    end
  end
end
