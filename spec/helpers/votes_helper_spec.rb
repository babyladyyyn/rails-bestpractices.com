require 'spec_helper'

describe VotesHelper do
  describe "vote_like_link" do
    before :each do
      @post = Factory(:post)
      @user = Factory(:user)
    end

    it "should return a link to login" do
      helper.stub!(:current_user).and_return(nil)
      helper.vote_like_link(@post).should == (link_to 'Like', new_user_session_path(:return_to => 'http://test.host'), :class => 'like-icon')
    end

    it "should return a like link" do
      helper.stub!(:current_user).and_return(@user)
      helper.vote_like_link(@post).should == (button_to 'Like', post_votes_path(@post, :like => true), :class => 'like-icon')
    end

    it "should return an alert link" do
      helper.stub!(:current_user).and_return(@user)
      vote = Factory(:vote, :user => @user, :voteable => @post, :like => true)
      helper.vote_like_link(@post).should == (link_to 'Like', "javascript:alert('You have voted like this best practices!');", :class => 'like-icon active')
    end

    it "should return a destroy like link" do
      helper.stub!(:current_user).and_return(@user)
      vote = Factory(:vote, :user => @user, :voteable => @post, :like => false)
      helper.vote_like_link(@post).should == (button_to 'Like', post_vote_path(@post, vote), :method => :delete, :class => 'like-icon')
    end
  end

  describe "vote_dislike_link" do
    before :each do
      @post = Factory(:post)
      @user = Factory(:user)
    end

    it "should return a link to login" do
      helper.stub!(:current_user).and_return(nil)
      helper.vote_dislike_link(@post).should == (link_to 'Dislike', new_user_session_path(:return_to => 'http://test.host'), :class => 'dislike-icon')
    end

    it "should return a dislike link" do
      helper.stub!(:current_user).and_return(@user)
      helper.vote_dislike_link(@post).should == (button_to 'Dislike', post_votes_path(@post, :like => false), :class => 'dislike-icon')
    end

    it "should return an alert link" do
      helper.stub!(:current_user).and_return(@user)
      vote = Factory(:vote, :user => @user, :voteable => @post, :like => false)
      helper.vote_dislike_link(@post).should == (link_to 'Dislike', "javascript:alert('You have voted dislike this best practices!');", :class => 'dislike-icon active')
    end

    it "should return a destroy dislike link" do
      helper.stub!(:current_user).and_return(@user)
      vote = Factory(:vote, :user => @user, :voteable => @post, :like => true)
      helper.vote_dislike_link(@post).should == (button_to 'Dislike', post_vote_path(@post, vote), :method => :delete, :class => 'dislike-icon')
    end
  end

  describe "voteable_link" do
    it "should get post vote link" do
      post = Factory(:post)
      vote = Factory(:vote, :voteable => post)
      helper.voteable_link(vote).should == post_path(post)
    end

    it "should get question vote link" do
      question = Factory(:question)
      vote = Factory(:vote, :voteable => question)
      helper.voteable_link(vote).should == question_path(question)
    end

    it "should get answer vote link" do
      question = Factory(:question)
      answer = Factory(:answer, :question => question)
      vote = Factory(:vote, :voteable => answer)
      helper.voteable_link(vote).should == question_path(question)
    end
  end
end
