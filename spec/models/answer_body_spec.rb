require 'spec_helper'

describe AnswerBody do
  include RailsBestPractices::Spec::Support

  should_be_markdownable
  should_belong_to :answer
  should_validate_presence_of :body
end
