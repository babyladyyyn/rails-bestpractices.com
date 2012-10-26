require 'spec_helper'

describe BlogPost do
  include RailsBestPractices::Spec::Support
  it { should belong_to(:user) }
end
