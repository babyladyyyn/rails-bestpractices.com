require 'spec_helper'

describe FooterCell do
  context "cell rendering" do

    context "rendering show" do
      subject { render_cell(:footer, :show) }

      it { should have_selector("li", :content => "Contact Us") }
      it { should have_selector("li", :content => "About Us") }
      it { should have_selector("li", :content => "Team Blog") }
      it { should have_selector("li", :content => "Advertise") }
    end

  end


  context "cell instance" do
    subject { cell(:footer) }

    it { should respond_to(:show) }
  end
end
