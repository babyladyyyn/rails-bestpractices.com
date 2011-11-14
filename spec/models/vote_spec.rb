require 'spec_helper'

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
      post.reload
      post.vote_points.should == orig_vote_point + 1
    end

    it "should decrement corresponding Post#vote_points if indicated as 'don like'" do
      orig_vote_point = post.vote_points
      Factory(:vote, :voteable => post, :like => false)
      post.reload
      post.vote_points.should == orig_vote_point - 1
    end

  end

  describe 'when deleted' do

    it "should decrement corresponding Post#vote_points if indicated as 'like'" do
      orig_vote_point = post.vote_points
      (vote = Factory(:vote, :voteable => post, :like => true)).destroy
      post.vote_points.should == orig_vote_point
    end

    it "should increment corresponding Post#vote_points if indicated as 'don like'" do
      orig_vote_point = post.vote_points
      (vote = Factory(:vote, :voteable => post, :like => false)).destroy
      post.vote_points.should == orig_vote_point
    end

  end

end

