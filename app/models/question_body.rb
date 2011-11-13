# == Schema Information
#
# Table name: question_bodies
#
#  id             :integer(4)      not null, primary key
#  body           :text
#  formatted_html :text
#  question_id    :integer(4)
#  created_at     :datetime
#  updated_at     :datetime
#

class QuestionBody < ActiveRecord::Base
  include Markdownable

  belongs_to :question

  validates_presence_of :body
end
