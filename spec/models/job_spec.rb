require 'spec_helper'

describe Job do
  it { should have_many(:job_job_types) }
  it { should have_many(:job_types) }
  it { should belong_to(:user) }
end
