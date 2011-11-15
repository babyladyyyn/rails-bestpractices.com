# == Schema Information
#
# Table name: post_bodies
#
#  id             :integer(4)      not null, primary key
#  body           :text
#  formatted_html :text
#  post_id        :integer(4)
#  created_at     :datetime
#  updated_at     :datetime
#

class PostBody < ActiveRecord::Base
  include Markdownable

  belongs_to :post

  validates :body, :presence => true
end
