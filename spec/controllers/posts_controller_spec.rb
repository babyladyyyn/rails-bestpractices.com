require 'spec_helper'

describe PostsController do
  context "index" do
    before :each do
      user = mock_model(User, :admin? => false)
      allow(controller).to receive(:authenticate_user!).and_return(true)
      allow(controller).to receive(:current_user).and_return(user)
      allow(user).to receive(:posts).and_return([])
    end

    it "should not allow invalid nav param" do
      posts = double([Post])
      expect(Post).to receive(:published).and_return(posts)
      expect(posts).to receive(:order).with("posts.id desc").and_return(posts)
      expect(posts).to receive(:paginate).and_return(posts)
      get :index, :nav => "wssiasbhpnlgw", :order => "desc"
      expect(response).to render_template("posts/index")
      expect(assigns[:posts]).to eq(posts)
    end

    it "should not use implemented" do
      posts = double([Post])
      expect(Post).to receive(:published).and_return(posts)
      expect(posts).to receive(:implemented).and_return(posts)
      expect(posts).to receive(:order).with("posts.id desc").and_return(posts)
      expect(posts).to receive(:paginate).and_return(posts)
      get :index, :nav => "implemented"
      expect(response).to render_template("posts/index")
      expect(assigns[:posts]).to eq(posts)
    end
  end
end
