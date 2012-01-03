require 'spec_helper'

describe JobJobType do
  it { should belong_to(:job) }
  it { should belong_to(:job_type) }
end
