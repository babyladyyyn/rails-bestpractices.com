class QuestionDecorator < ApplicationDecorator
  decorates :question

  def statistics
    h.content_tag(:p, "#{model.vote_points} votes") +
      h.content_tag(:p, "#{model.answers_count} answers") +
      h.content_tag(:p, "#{model.view_count} views")
  end

  def link
    h.link_to title, h.question_path(model)
  end
end
