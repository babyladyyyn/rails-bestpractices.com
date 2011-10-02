module NotificationsHelper
  def notification_message(notification)
    notifierable = notification.cached_notifierable
    if notifierable.is_a? Comment
      comment = notifierable
      "#{comment_user_link(comment)} commented on #{link_to comment.parent_name, comment_parent_link(comment)}"
    elsif notifierable.is_a? Answer
      answer = notifierable
      "#{link_to answer.cached_user.login, user_path(answer.cached_user)} answered on Question #{link_to answer.cached_question.title, question_path(answer.cached_question)}"
    end
  end
end
