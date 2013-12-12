require 'spec_helper'

describe Vote do

  include RailsBestPractices::Spec::Support
  should_be_user_ownable

  it { should belong_to(:voteable) }

  let(:post) { FactoryGirl.create(:post) }
  let(:vote) { FactoryGirl.create(:vote) }

  describe 'when created' do

    it "should increment corresponding Post#vote_points if indicated as 'like'" do
      expect { FactoryGirl.create(:vote, voteable: post, like: true) }.to change { post.reload.vote_points }.by(1)
    end

    it "should decrement corresponding Post#vote_points if indicated as 'don like'" do
      expect { FactoryGirl.create(:vote, voteable: post, like: false) }.to change { post.reload.vote_points }.by(-1)
    end

  end

  describe 'when deleted' do

    it "should decrement corresponding Post#vote_points if indicated as 'like'" do
      orig_vote_point = post.vote_points
      (vote = FactoryGirl.create(:vote, :voteable => post, :like => true)).destroy
      expect(post.vote_points).to eq(orig_vote_point)
    end

    it "should increment corresponding Post#vote_points if indicated as 'don like'" do
      orig_vote_point = post.vote_points
      (vote = FactoryGirl.create(:vote, :voteable => post, :like => false)).destroy
      expect(post.vote_points).to eq(orig_vote_point)
    end

  end

end

