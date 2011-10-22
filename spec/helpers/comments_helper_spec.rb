require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe CommentsHelper do
  describe "comment_user_link" do
    it "should get comment user link with logged in user" do
      comment_user = Factory(:user, :login => 'comment_user')
      comment = Factory(:comment, :user => comment_user)

      helper.comment_user_link(comment).should == link_to('comment_user', user_path(comment_user))
    end

    it "should get comment user link with non logged in user" do
      comment = Factory(:comment, :user => nil, :username => "non logged in user")

      helper.comment_user_link(comment).should == "non logged in user"
    end
  end

  describe "comment_parent_link" do
    it "should get comment parent link for post" do
      post = Factory(:post)
      comment = Factory(:comment, :commentable => post)

      helper.comment_parent_link(comment).should == post_path(post)
    end

    it "should get comment parent link for question" do
      question = Factory(:question)
      comment = Factory(:comment, :commentable => question)

      helper.comment_parent_link(comment).should == question_path(question)
    end

    it "should get comment parent link for answer" do
      question = Factory(:question)
      answer = Factory(:answer, :question => question)
      comment = Factory(:comment, :commentable => answer)

      helper.comment_parent_link(comment).should == question_path(question)
    end
  end
end
