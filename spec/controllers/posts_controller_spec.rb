require 'spec_helper'

describe PostsController do
  context "index" do
    before :each do
      user = mock_model(User, :admin? => false)
      controller.stub(:authenticate_user!).and_return(true)
      controller.stub(:current_user).and_return(user)
      user.stub(:posts).and_return([])
    end

    it "should not allow invalid nav param" do
      posts = double([Post])
      Post.should_receive(:published).and_return(posts)
      posts.should_receive(:order).with("posts.id desc").and_return(posts)
      posts.should_receive(:paginate).and_return(posts)
      get :index, :nav => "wssiasbhpnlgw", :order => "desc"
      response.should render_template("posts/index")
      assigns[:posts].should == posts
    end

    it "should not use implemented" do
      posts = double([Post])
      Post.should_receive(:published).and_return(posts)
      posts.should_receive(:implemented).and_return(posts)
      posts.should_receive(:order).with("posts.id desc").and_return(posts)
      posts.should_receive(:paginate).and_return(posts)
      get :index, :nav => "implemented"
      response.should render_template("posts/index")
      assigns[:posts].should == posts
    end
  end
end
