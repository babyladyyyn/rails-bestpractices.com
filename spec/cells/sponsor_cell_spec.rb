require 'spec_helper'

describe SponsorCell do
  context "cell rendering" do

    context "rendering active" do
      before do
        @sponsor = Factory(:sponsor, :active => true)
      end
      subject { render_cell(:sponsor, :active) }

      it { should have_selector("h3", :content => "Sponsors") }
      it { should have_selector("a img[src='#{@sponsor.image_url}']") }
    end

  end


  context "cell instance" do
    subject { cell(:sponsor) }

    it { should respond_to(:active) }
  end
end
