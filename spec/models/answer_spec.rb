require 'spec_helper'

describe Answer do

  include RailsBestPractices::Spec::Support
  should_be_user_ownable
  should_be_voteable
  should_be_commentable

  should_be_tweetable do |answer|
    {
      :title => "Answer for #{answer.question.title}",
      :path => "questions/#{answer.question.to_param}"
    }
  end

  it { should belong_to(:question) }

  describe 'converting to a post' do

    let(:question) { Factory(:question, :tag_list => 'tests', :title => 'Howto write awesome tests') }
    let(:answer) { Factory(:answer, :question => question, :answer_body => Factory(:answer_body)) }

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

