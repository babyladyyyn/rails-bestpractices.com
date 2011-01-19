# == Schema Information
#
# Table name: drops
#
#  id             :integer(4)      not null, primary key
#  title          :string(255)
#  body           :text
#  user_id        :integer(4)
#  formatted_html :text
#  description    :text
#  kind           :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  tag_list       :string(255)
#

require 'spec_helper'

describe Drop do
  should_belong_to :user
  should_validate_presence_of :title, :kind, :tag_list, :body
end

