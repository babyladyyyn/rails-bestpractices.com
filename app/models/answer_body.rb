class AnswerBody < ActiveRecord::Base
  include Markdownable

  belongs_to :answer

  validates :body, :presence => true
end
