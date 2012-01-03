require 'spec_helper'

describe PostBody do
  include RailsBestPractices::Spec::Support

  should_be_markdownable
  it { should belong_to(:post) }
  it { should validate_presence_of(:body) }
end
