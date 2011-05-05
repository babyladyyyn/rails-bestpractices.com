require 'spec_helper'

describe JobJobType do
  should_belong_to :job
  should_belong_to :job_type
end
