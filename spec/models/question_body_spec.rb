require 'spec_helper'

describe QuestionBody do
  include RailsBestPractices::Spec::Support

  should_be_markdownable
  should_belong_to :question
  should_validate_presence_of :body
end
