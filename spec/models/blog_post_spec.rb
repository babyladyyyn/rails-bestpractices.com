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
  include RailsBestPractices::Spec::Support
  should_belong_to :user
  should_be_commentable
end

