class AnswerDecorator < ApplicationDecorator
  decorates :answer

  def question_link
    h.link_to model.cached_question.title, h.question_path(model.cached_question)
  end
end
