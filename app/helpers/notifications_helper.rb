module NotificationsHelper
  def notification_message(notification)
    notifierable = notification.cached_notifierable
    if notifierable.is_a? Answer
      answer = notifierable
      "#{link_to answer.cached_user.login, user_path(answer.cached_user)} answered on Question #{link_to answer.cached_question.title, question_path(answer.cached_question)}".html_safe
    end
  end
end
