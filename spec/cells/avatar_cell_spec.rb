require 'spec_helper'

describe AvatarCell do
  context "cell rendering" do

    context "rendering show" do
      it "should render with user" do
        user = FactoryGirl.create(:user)
        response = render_cell(:avatar, :show, user)
        response.should have_selector("img[alt='#{user.login}']")
      end

      it "should render without user" do
        default_gravatar_url = "http://gravatar.com/avatar/b642b4217b34b1e8d3bd915fc65c4452.png?d=mm&r=PG&s=32"
        response = render_cell(:avatar, :show)
        response.should have_selector("img[src='#{default_gravatar_url}']")
      end
    end

  end


  context "cell instance" do
    subject { cell(:avatar) }

    it { should respond_to(:show) }
  end
end
