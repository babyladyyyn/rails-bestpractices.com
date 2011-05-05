require 'spec_helper'

describe JobType do
  should_have_many :job_job_types
  should_have_many :jobs, :through => :job_job_types
end
