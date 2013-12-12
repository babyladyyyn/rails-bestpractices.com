require 'spec_helper'

describe JobsController do
  context "index" do
    before :each do
      user = mock_model(User, :admin? => false)
      allow(controller).to receive(:authenticate_user!).and_return(true)
      allow(controller).to receive(:current_user).and_return(user)
      allow(user).to receive(:jobs).and_return([])
    end

    it "should be successful" do
      jobs = double([Job])
      expect(Job).to receive(:published).and_return(jobs)
      expect(jobs).to receive(:order).with("created_at desc").and_return(jobs)
      expect(jobs).to receive(:paginate).and_return(jobs)

      get 'index'
      expect(response).to render_template("jobs/index")
      expect(assigns[:jobs]).to eq(jobs)
    end
  end

end
