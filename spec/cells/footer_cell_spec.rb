require 'spec_helper'

describe FooterCell do
  context "cell rendering" do

    context "rendering show" do
      subject { render_cell(:footer, :show) }

      it { should have_selector("li", :text => "Contact Us") }
      it { should have_selector("li", :text => "About Us") }
      it { should have_selector("li", :text => "Team Blog") }
      it { should have_selector("li", :text => "Advertise") }
    end

  end


  context "cell instance" do
    subject { cell(:footer) }

    it { should respond_to(:show) }
  end
end
