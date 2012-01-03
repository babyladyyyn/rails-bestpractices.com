require 'spec_helper'

describe QuestionBody do
  include RailsBestPractices::Spec::Support

  should_be_markdownable
  it { should belong_to(:question) }
  it { should validate_presence_of(:body) }
end
