require 'spec_helper'

describe BlogPost do
  include RailsBestPractices::Spec::Support
  should_belong_to :user
  should_be_commentable
end

