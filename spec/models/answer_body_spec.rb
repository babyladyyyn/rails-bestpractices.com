require 'spec_helper'

describe AnswerBody do
  include RailsBestPractices::Spec::Support

  should_be_markdownable
  it { should belong_to(:answer) }
  it { should validate_presence_of(:body) }
end
