class Sponsor < ActiveRecord::Base
  validates_presence_of :name, :website_url, :image_url
  validates_uniqueness_of :name

  has_many :sponsor_tracks
end
