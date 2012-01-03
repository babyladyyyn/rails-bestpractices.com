require 'spec_helper'

describe Sponsor do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:website_url) }
  it { should validate_presence_of(:image_url) }
  describe "when name validation is required" do
    before { Factory.create(:sponsor) }
    it { should validate_uniqueness_of(:name) }
  end
  it { should have_many(:sponsor_tracks) }
end
