require 'spec_helper'

describe SponsorsController do

  describe "GET 'show'" do
    it "should be successful" do
      sponsor = Factory.stub(:sponsor)
      Sponsor.should_receive(:find).with("1").and_return(sponsor)
      sponsor_tracks = []
      sponsor.should_receive(:sponsor_tracks).and_return(sponsor_tracks)
      sponsor_tracks.should_receive(:create)

      get 'show', :id => "1"
      response.should redirect_to(sponsor.website_url)
    end
  end

end
