require 'spec_helper'

describe Sponsor do
  should_validate_presence_of :name, :website_url, :image_url
  describe "when name validation is required" do
    before { Factory.create(:sponsor) }
    should_validate_uniqueness_of :name
  end

  should_have_many :sponsor_tracks
end
