# == Schema Information
#
# Table name: job_partners
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  token      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class JobPartner < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  validates_presence_of :name, :token
end
