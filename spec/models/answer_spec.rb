# == Schema Information
#
# Table name: answers
#
#  id             :integer(4)      not null, primary key
#  body           :text(16777215)
#  formatted_html :text(16777215)
#  user_id        :integer(4)
#  vote_points    :integer(4)      default(0)
#  question_id    :integer(4)
#  created_at     :datetime
#  updated_at     :datetime
#  comments_count :integer(4)      default(0)
#

require 'spec_helper'

describe Answer do

  include RailsBestPractices::Spec::Support
  should_be_user_ownable
  should_be_voteable
  should_be_commentable
  should_have_entries_per_page 10

  should_be_tweetable do |answer|
    {
      :title => "Answer for #{answer.question.title}",
      :path => "questions/#{answer.question.to_param}"
    }
  end

  should_belong_to :question, :counter_cache => true

  describe 'converting to a post' do

    let(:question) { Factory(:question, :tag_list => 'tests', :title => 'Howto write awesome tests') }
    let(:answer) { Factory(:answer, :question => question, :answer_body => Factory(:answer_body, :body => '(empty)')) }

    it "should use question's title as post title" do
      answer.to_post.title.should == question.title
    end

    it "should use question's tag_list as post tag_list" do
      answer.to_post.tag_list.should == question.tag_list
    end

    it "should use body as post's body" do
      answer.to_post.body.should == answer.body
    end

  end

end

