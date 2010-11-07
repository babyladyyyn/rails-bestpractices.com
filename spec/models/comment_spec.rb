require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe Comment do

  include RailsBestPractices::Spec::Support
  should_be_user_ownable
  should_have_entries_per_page 10

  should_belong_to :commentable, :polymorphic => true
  should_validate_presence_of :body

  describe 'validating username when it is required' do
    subject { Factory(:comment, :user => nil, :username => 'flyerhzm') }
    should_validate_presence_of :username
  end

  describe 'validating username when it is not required' do
    subject { Factory(:comment) }
    should_not_validate_presence_of :username
  end

  it 'should be scopable by post type (sorted by creation timing)' do
    Comment.delete_all
    comment1 = Factory(:comment, :commentable => Factory(:post), :created_at => 3.days.ago)
    comment2 = Factory(:comment, :commentable => Factory(:post), :created_at => 1.days.ago)
    Comment.post.should == [comment2, comment1]
  end

  describe 'parent name' do

    it "should return commentable's title when commentable is a Question" do
      question = Factory(:question, :title => 'Awesome Question')
      comment = Factory(:comment, :commentable => question)
      comment.parent_name.should == "Question #{question.title}"
    end

    it "should return commentable's title when commentable is a Post" do
      post = Factory(:post, :title => 'Awesome Post')
      comment = Factory(:comment, :commentable => post)
      comment.parent_name.should == "Post #{post.title}"
    end

    it "should return commentable's question title when commentable is an Answer" do
      question = Factory(:question, :title => 'Awesome Question')
      comment = Factory(:comment, :commentable => Factory(:answer, :question => question))
      comment.parent_name.should == "Answer of #{question.title}"
    end
  end

  describe "user_name" do
    it "should show user.login" do
      user = Factory(:user, :login => 'flyerhzm')
      comment = Factory(:comment, :user => user)
      comment.user_name.should == 'flyerhzm'
    end

    it "should show comment.username" do
      comment = Factory(:comment, :user => nil, :username => 'test')
      comment.user_name.should == 'test'
    end
  end

  describe "user_email" do
    it "should show user.email" do
      user = Factory(:user, :email => 'flyerhzm@gmail.com')
      comment = Factory(:comment, :user => user)
      comment.user_email.should == 'flyerhzm@gmail.com'
    end

    it "should show comment.email" do
      comment = Factory(:comment, :user => nil, :username => 'test', :email => 'test@test.com')
      comment.user_email.should == 'test@test.com'
    end
  end

end
