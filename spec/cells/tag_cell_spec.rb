require 'spec_helper'

describe TagCell do
  context "cell rendering" do

    context "renderding list" do
      before do
        @post = FactoryGirl.create(:post, :tag_list => "ruby, rails")
      end
      subject { render_cell(:tag, :list, @post) }

      it { should have_link("ruby") }
      it { should have_link("rails") }
    end

  end


  context "cell instance" do
    subject { cell(:tag) }

    it { should respond_to(:list) }
  end
end
