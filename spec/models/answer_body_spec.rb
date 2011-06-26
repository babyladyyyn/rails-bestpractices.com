require 'spec_helper'

describe AnswerBody do
  include RailsBestPractices::Spec::Support

  should_be_markdownable
  should_validate_presence_of :body
end
