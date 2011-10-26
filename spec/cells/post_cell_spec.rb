require 'spec_helper'

describe PostCell do
  context "cell rendering" do

    context "rendering related" do
      before do
        @post = Factory(:post, :tag_list => 'model')
        @post1 = Factory(:post, :tag_list => 'model')
        @post2 = Factory(:post, :tag_list => 'model')
      end
      subject { render_cell(:post, :related, @post) }

      it { should have_content("related best practices:") }
      it { should have_link(@post1.title) }
      it { should have_link(@post2.title) }
    end

    context "rednering prev_next" do
      before do
        @post1 = Factory(:post)
        @post2 = Factory(:post)
        @post3 = Factory(:post)
      end

      context "@post1" do
        subject { render_cell(:post, :prev_next, @post1) }

        it { should have_link(@post2.title) }
      end

      context "@post2" do
        subject { render_cell(:post, :prev_next, @post2) }

        it { should have_link(@post1.title) }
        it { should have_link(@post3.title) }
      end

      context "@post3" do
        subject { render_cell(:post, :prev_next, @post3) }

        it { should have_link(@post2.title) }
      end
    end

  end


  context "cell instance" do
    subject { cell(:post) }

    it { should respond_to(:related) }
  end
end
