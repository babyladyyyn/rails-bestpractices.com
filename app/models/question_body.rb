class QuestionBody < ActiveRecord::Base
  include Markdownable

  belongs_to :question

  validates_presence_of :body
end
