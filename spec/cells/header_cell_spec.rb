require 'spec_helper'

describe HeaderCell do
  context "cell rendering" do

    context "rendering show" do
      before { @user = FactoryGirl.create(:user) }
      subject { render_cell(:header, :show, @user) }

      it { should have_selector("h1", :content => "Rails Best Practices") }
    end

  end


  context "cell instance" do
    subject { cell(:header) }

    it { should respond_to(:show) }
  end
end
