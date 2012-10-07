# == Schema Information
#
# Table name: sponsors
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  website_url :string(255)
#  image_url   :string(255)
#  active      :boolean(1)      default(TRUE)
#  created_at  :datetime
#  updated_at  :datetime
#

class Sponsor < ActiveRecord::Base

  include ActiveModel::ForbiddenAttributesProtection
  include Cacheable

  validates_presence_of :name, :website_url, :image_url
  validates_uniqueness_of :name

  has_many :sponsor_tracks

  scope :active, where(:active => true)

  model_cache do
    with_key
  end
end
