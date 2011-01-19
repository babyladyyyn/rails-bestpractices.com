# == Schema Information
#
# Table name: blog_posts
#
#  id             :integer(4)      not null, primary key
#  title          :string(255)
#  body           :text
#  user_id        :integer(4)
#  created_at     :datetime
#  updated_at     :datetime
#  comments_count :integer(4)      default(0)
#

require 'spec_helper'

describe BlogPost do
  pending "add some examples to (or delete) #{__FILE__}"
end

