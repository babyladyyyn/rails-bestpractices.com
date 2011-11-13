# == Schema Information
#
# Table name: answer_bodies
#
#  id             :integer(4)      not null, primary key
#  body           :text
#  formatted_html :text
#  answer_id      :integer(4)
#  created_at     :datetime
#  updated_at     :datetime
#

class AnswerBody < ActiveRecord::Base
  include Markdownable

  belongs_to :answer

  validates_presence_of :body
end
