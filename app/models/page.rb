# == Schema Information
#
# Table name: pages
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  body       :text(16777215)
#  created_at :datetime
#  updated_at :datetime
#

class Page < ActiveRecord::Base

  include Cacheable

  validates_presence_of :name

  model_cache do
    with_attribute :name
  end
end
