require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe Vote do

  include RailsBestPractices::Spec::Support
  should_be_user_ownable

  should_belong_to :voteable, :polymorphic => true

  let(:post) { Factory(:post) }
  let(:vote) { Factory(:vote) }

  describe 'when created' do

    it "should increment corresponding Post#vote_points if indicated as 'like'" do
      orig_vote_point = post.vote_points
      Factory(:vote, :voteable => post, :like => true)
      post.vote_points.should equal(orig_vote_point.succ)
    end

    it "should decrement corresponding Post#vote_points if indicated as 'don like'" do
      orig_vote_point = post.vote_points
      Factory(:vote, :voteable => post, :like => false)
      post.vote_points.should equal(orig_vote_point.pred)
    end

  end

  describe 'when deleted' do

    it "should decrement corresponding Post#vote_points if indicated as 'like'" do
      orig_vote_point = post.vote_points
      (vote = Factory(:vote, :voteable => post, :like => true)).destroy
      post.vote_points.should equal(orig_vote_point)
    end

    it "should increment corresponding Post#vote_points if indicated as 'don like'" do
      orig_vote_point = post.vote_points
      (vote = Factory(:vote, :voteable => post, :like => false)).destroy
      post.vote_points.should equal(orig_vote_point)
    end

  end

  describe '#voteable_name' do

    it "should be voteable's question title if voteable is an answer" do
      title = 'How to write fantastic tests'
      answer = Factory(:answer, :question => Factory(:question, :title => title))
      vote.update_attributes(:voteable => answer)
      vote.voteable_name.should == title
    end

    it "should be voteable's title if voteable is an answer" do
      title = 'Writing fantastic tests'
      vote.update_attributes(:voteable => Factory(:post, :title => title))
      vote.voteable_name.should == title
    end

  end


end
