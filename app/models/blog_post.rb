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

  include Commentable
  include Cacheable

  belongs_to :user

  validates_presence_of :title, :body
  validates_uniqueness_of :title

  model_cache do
    with_key
    with_association :user
  end

  def self.per_page
    5
  end

  def to_param
    "#{id}-#{title.parameterize}"
  end
end

