require 'spec_helper'

describe Question do

  let(:question) { Factory.create(:question) }

  include RailsBestPractices::Spec::Support
  should_be_taggable
  should_be_user_ownable
  should_be_commentable
  should_be_voteable

  should_be_tweetable do |question|
    {
      :title => "Question: #{question.title}",
      :path => "questions/#{question.to_param}",
    }
  end

  it { should have_many(:answers) }

  describe 'when title validation is required' do
    before { Factory.create(:question) }
    it { should validate_presence_of(:title) }
    it { should validate_uniqueness_of(:title) }
  end

  it 'should be scopable by not-answered' do
    Question.delete_all
    questions = [Factory(:question)]
    questions << Factory(:answer).question
    Question.not_answered.should == questions[0..0]
  end

  it "should reflect :id & :title when converted to param" do
    question.title = 'Howto Write Super Mighty Proc'
    question.to_param.should == question.instance_exec{"#{id}-#{title.parameterize}"}
  end

  it "should tweet after create" do
    Delayed::Job.should_receive(:enqueue)
    Factory(:question)
  end

end

