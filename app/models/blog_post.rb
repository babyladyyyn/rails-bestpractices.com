class BlogPost < ActiveRecord::Base
  include Commentable
  belongs_to :user

  validates_presence_of :title, :body
  validates_uniqueness_of :title

  def self.per_page
    10
  end

  def to_param
    "#{id}-#{title.parameterize}"
  end
end
