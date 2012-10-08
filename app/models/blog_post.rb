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

class BlogPost < ActiveRecord::Base

  include ActiveModel::ForbiddenAttributesProtection
  include Commentable
  include Cacheable

  belongs_to :user

  validates :title, :presence => true, :uniqueness => true
  validates :body, :presence => true

  model_cache do
    with_key
    with_association :user
  end

  paginates_per 5

  def to_param
    "#{id}-#{title.parameterize}"
  end
end

