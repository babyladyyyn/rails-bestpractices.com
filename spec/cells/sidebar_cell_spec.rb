require 'spec_helper'

describe SidebarCell do
  context "cell rendering" do

    context "rendering jobs" do
      before do
        @job1 = Factory(:job, :published => true)
        @job2 = Factory(:job, :published => true)
      end
      subject { render_cell(:sidebar, :display) }

      it { should have_selector("h3", :content => "Top Ruby and Rails jobs") }
      it { should have_link(@job1.title) }
      it { should have_content(@job1.company) }
      it { should have_content(@job1.location) }
      it { should have_link(@job2.title) }
      it { should have_content(@job2.company) }
      it { should have_content(@job2.location) }
      it { should have_link("View All Jobs") }
      it { should have_link("Post a Job") }
    end

    context "rendering sponsors" do
      before do
        @sponsor = Factory(:sponsor, :active => true)
      end
      subject { render_cell(:sidebar, :display) }

      it { should have_selector("h3", :content => "Sponsors") }
      it { should have_selector("a img[src='#{@sponsor.image_url}']") }
    end

    context "rendering posts-navigation" do
      subject { render_cell(:sidebar, :display) }

      it { should have_link("Recent Comments") }
      it { should have_link("All Best Practices") }
    end

    context "rendering blog posts" do
      before do
        @blog_post1 = Factory(:blog_post)
        @blog_post2 = Factory(:blog_post)
      end
      subject { render_cell(:sidebar, :display, "blog_posts") }

      it { should have_selector("h3", :content => "Recent Blog Post") }
      it { should have_link(@blog_post1.title) }
      it { should have_link(@blog_post2.title) }
    end

    context "rendering important" do
      before do
        @tag1 = Factory(:tag, :important => true)
        @tag2 = Factory(:tag, :important => true)
      end
      subject { render_cell(:sidebar, :display, "posts") }

      it { should have_selector("h3", :content => "Tags") }
      it { should have_link(@tag1.name) }
      it { should have_link(@tag2.name) }
    end

  end


  context "cell instance" do
    subject { cell(:sidebar) }

    it { should respond_to(:display) }
  end
end
