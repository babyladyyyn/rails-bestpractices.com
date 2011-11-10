class PostBody < ActiveRecord::Base
  include Markdownable

  belongs_to :post

  validates :body, :presence => true
end
