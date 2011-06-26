class AnswerBody < ActiveRecord::Base
  include Markdownable

  belongs_to :answer

  validates_presence_of :body
end
