require 'spec_helper'

describe JobCell do
  context "cell rendering" do

    context "rendering recent" do
      before do
        @job1 = Factory(:job, :published => true)
        @job2 = Factory(:job, :published => true)
      end
      subject { render_cell(:job, :recent) }

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

  end


  context "cell instance" do
    subject { cell(:job) }
    it { should respond_to(:recent) }
  end
end
