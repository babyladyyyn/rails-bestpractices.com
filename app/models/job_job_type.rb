class JobJobType < ActiveRecord::Base
  belongs_to :job
  belongs_to :job_type
end
