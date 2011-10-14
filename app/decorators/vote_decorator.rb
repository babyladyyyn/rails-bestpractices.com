class VoteDecorator < ApplicationDecorator
  decorates :vote

  def voteable_name
    if model.cached_voteable.is_a? Answer
      model.cached_voteable.cached_question.title
    else
      model.cached_voteable.title
    end
  end

  def voteable_link
    if model.voteable.is_a? Answer
      h.question_path(model.cached_voteable.cached_question)
    else
      h.polymorphic_path(model.cached_voteable)
    end
  end

end
