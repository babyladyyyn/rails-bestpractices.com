require 'spec_helper'

describe Job do
  should_have_many :job_job_types
  should_have_many :job_types, :through => :job_job_types, :source => :job_type
  should_belong_to :user
end
