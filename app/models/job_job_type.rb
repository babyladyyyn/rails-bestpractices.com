# == Schema Information
#
# Table name: job_job_types
#
#  id          :integer(4)      not null, primary key
#  job_id      :integer(4)
#  job_type_id :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

class JobJobType < ActiveRecord::Base
  belongs_to :job
  belongs_to :job_type
end
