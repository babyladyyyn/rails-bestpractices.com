# == Schema Information
#
# Table name: questions
#
#  id             :integer(4)      not null, primary key
#  title          :string(255)
#  body           :text(16777215)
#  formatted_html :text(16777215)
#  user_id        :integer(4)
#  vote_points    :integer(4)      default(0)
#  view_count     :integer(4)      default(0)
#  answers_count  :integer(4)      default(0)
#  created_at     :datetime
#  updated_at     :datetime
#  comments_count :integer(4)      default(0)
#

require 'spec_helper'

describe Question do

  let(:question) { Factory.create(:question) }

  include RailsBestPractices::Spec::Support
  should_be_taggable
  should_be_user_ownable
  should_be_commentable
  should_be_voteable
  should_have_entries_per_page 10

  should_be_tweetable do |question|
    {
      :title => "Question: #{question.title}",
      :path => "questions/#{question.to_param}",
    }
  end

  should_have_many :answers, :dependent => :destroy

  describe 'when title validation is required' do
    before { Factory.create(:question) }
    should_validate_presence_of :title
    should_validate_uniqueness_of :title
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

