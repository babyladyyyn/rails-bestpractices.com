class NotifyAnswerWorker
  include Sidekiq::Worker

  def perform(answer_id)
    answer = Answer.find_cached(answer_id)
    question = answer.cached_question
    emails = []

    email = question.cached_user.email
    if email.present? and question.cached_user != answer.cached_user
      emails << email
      NotificationMailer.notify_answer(email, answer).deliver if question.cached_user.answer_question?
    end

    answers = question.answers
    answers.each do |a|
      email = a.cached_user.email
      if email.present? and email != answer.cached_user.email and !emails.include? email
        emails << email
        NotificationMailer.notify_answer(email, answer).deliver if a.user.after_question_answer?
      end
    end
  end
end
