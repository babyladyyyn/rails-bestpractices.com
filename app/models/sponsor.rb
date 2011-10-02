class Sponsor < ActiveRecord::Base
  include Cacheable

  validates_presence_of :name, :website_url, :image_url
  validates_uniqueness_of :name

  has_many :sponsor_tracks

  scope :active, where(:active => true)

  model_cache do
    with_key
  end
end
