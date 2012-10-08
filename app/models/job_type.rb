# == Schema Information
#
# Table name: job_types
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class JobType < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  has_many :job_job_types
  has_many :jobs, :through => :job_job_types
end
