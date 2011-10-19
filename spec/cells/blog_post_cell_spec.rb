require 'spec_helper'

describe BlogPostCell do
  context "cell rendering" do

    context "rendering recent" do
      before do
        @blog_post1 = Factory(:blog_post)
        @blog_post2 = Factory(:blog_post)
      end
      subject { render_cell(:blog_post, :recent) }

      it { should have_selector("h3", :content => "Recent Blog Post") }
      it { should have_link(@blog_post1.title) }
      it { should have_link(@blog_post2.title) }
    end

  end


  context "cell instance" do
    subject { cell(:blog_post) }

    it { should respond_to(:recent) }
  end
end
