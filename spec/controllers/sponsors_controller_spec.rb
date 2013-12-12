require 'spec_helper'

describe SponsorsController do

  describe "GET 'show'" do
    it "should be successful" do
      sponsor = FactoryGirl.build(:sponsor)
      expect(Sponsor).to receive(:find_cached).with("1").and_return(sponsor)
      sponsor_tracks = []
      expect(sponsor).to receive(:sponsor_tracks).and_return(sponsor_tracks)
      expect(sponsor_tracks).to receive(:create)

      get 'show', :id => "1"
      expect(response).to redirect_to(sponsor.website_url)
    end
  end

end
