require 'spec_helper'

describe CommentCell do
  context "cell rendering" do

    context "rendering show" do
      before do
        @post = Factory(:post)
        @comment1 = Factory(:comment, :body => "first comment", :commentable => @post)
        @comment2 = Factory(:comment, :body => "second comment", :commentable => @post)
      end

      subject { render_cell(:comment, :show, @post) }

      it { should have_selector("h3", :content => "Comments") }
      it { should have_link(@comment1.user.login) }
      it { should have_selector(".wikistyle", :content => "first comment") }
      it { should have_link(@comment2.user.login) }
      it { should have_selector(".wikistyle", :content => "second comment") }
    end

    context "rendering new" do
      before do
        @post = Factory(:post)
        @user = Factory(:user)
        @comment = @post.comments.build
      end

      subject { render_cell(:comment, :new, @post, @comment, @user) }

      it { should have_selector("form.comment") }
      it { should have_button("Comment") }
    end

  end


  context "cell instance" do
    subject { cell(:comment) }

    it { should respond_to(:show) }
  end
end
