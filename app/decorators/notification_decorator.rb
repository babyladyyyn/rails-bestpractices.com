class NotificationDecorator < ApplicationDecorator
  decorates :notification

  def message
    notifierable = model.cached_notifierable
    if notifierable.is_a? Comment
      comment = CommentDecorator.new(notifierable)
      comment.user_link + " commented on " + comment.parent_link
    elsif notifierable.is_a? Answer
      answer = AnswerDecorator.new(notifierable)
      answer.user_link + " answered on Question " + answer.question_link
    end
  end
end
