require 'spec_helper'

describe JobType do
  it { should have_many(:job_job_types) }
  it { should have_many(:jobs) }
end
