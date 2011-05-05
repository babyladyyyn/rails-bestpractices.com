class JobType < ActiveRecord::Base
  has_many :job_job_types
  has_many :jobs, :through => :job_job_types
end
