class PostBody < ActiveRecord::Base
  include Markdownable

  belongs_to :post

  validates_presence_of :body
end
