require 'spec_helper'

describe JobsController do
  context "index" do
    before :each do
      user = mock_model(User, :admin? => false)
      controller.stub!(:authenticate_user!).and_return(true)
      controller.stub!(:current_user).and_return(user)
      user.stub!(:jobs).and_return([])
    end

    it "should be successful" do
      jobs = mock([Job])
      Job.should_receive(:published).and_return(jobs)
      jobs.should_receive(:order).with("created_at desc").and_return(jobs)
      jobs.should_receive(:paginate).and_return(jobs)

      get 'index'
      response.should render_template("jobs/index")
      assigns[:jobs].should == jobs
    end
  end

end
