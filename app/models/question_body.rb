class QuestionBody < ActiveRecord::Base
  include Markdownable

  belongs_to :question

  validates :body, :presence => true
end
