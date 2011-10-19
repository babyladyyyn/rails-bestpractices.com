require 'spec_helper'

describe JobPartnerCell do
  context "cell rendering" do

    context "rendering hint" do
      before do
        @job_partner = Factory(:job_partner)
      end
      subject { render_cell(:job_partner, :hint) }

      it { should have_content("All jobs will be synchronized with") }
      it { should have_link(@job_partner.name) }
    end

  end


  context "cell instance" do
    subject { cell(:job_partner) }
    it { should respond_to(:hint) }
  end
end
