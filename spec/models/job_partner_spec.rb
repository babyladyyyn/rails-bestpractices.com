require 'spec_helper'

describe JobPartner do
  should_validate_presence_of :name
  should_validate_presence_of :token
end
