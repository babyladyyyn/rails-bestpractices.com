require 'spec_helper'

describe Drop do
  should_belong_to :user
  should_validate_presence_of :title, :kind, :tag_list, :body
end
