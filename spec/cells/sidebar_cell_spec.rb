require 'spec_helper'

describe SidebarCell do
  context "cell rendering" do

    context "rendering jobs" do
      before do
        @job1 = FactoryGirl.create(:job, :published => true)
        @job2 = FactoryGirl.create(:job, :published => true)
      end
      subject { render_cell(:sidebar, :display) }

      it { should have_selector("h3", :text => "Top Ruby and Rails Jobs") }
      it { should have_link(@job1.title) }
      it { should have_content(@job1.company) }
      it { should have_content(@job1.location) }
      it { should have_link(@job2.title) }
      it { should have_content(@job2.company) }
      it { should have_content(@job2.location) }
      it { should have_link("View All Jobs") }
      it { should have_link("Post a Job") }
    end

    context "rendering posts-navigation" do
      subject { render_cell(:sidebar, :display) }

      it { should have_link("All Best Practices") }
    end

    context "rendering blog posts" do
      before do
        @blog_post1 = FactoryGirl.create(:blog_post)
        @blog_post2 = FactoryGirl.create(:blog_post)
      end
      subject { render_cell(:sidebar, :display, "blog_posts") }

      it { should have_selector("h3", :text => "Recent Blog Post") }
      it { should have_link(@blog_post1.title) }
      it { should have_link(@blog_post2.title) }
    end

    context "rendering important" do
      before do
        @tag1 = FactoryGirl.create(:tag, :important => true)
        @tag2 = FactoryGirl.create(:tag, :important => true)
      end
      subject { render_cell(:sidebar, :display, "posts") }

      it { should have_selector("h3", :text => "Tags") }
      it { should have_link(@tag1.name) }
      it { should have_link(@tag2.name) }
    end

  end


  context "cell instance" do
    subject { cell(:sidebar) }

    it { should respond_to(:display) }
  end
end
