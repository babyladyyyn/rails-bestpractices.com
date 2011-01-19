# == Schema Information
#
# Table name: pages
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  body       :text(16777215)
#  created_at :datetime
#  updated_at :datetime
#

require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe Page do
  should_validate_presence_of :name
end

