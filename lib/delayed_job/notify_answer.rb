class DelayedJob::NotifyAnswer < Struct.new(:answer_id)
  def perform
    answer = Answer.find(answer_id)
    question = answer.question
    emails = []

    email = question.user.email
    if email.present? and question.user != answer.user
      emails << email
      NotificationMailer.notify_answer(email, answer).deliver if question.user.answer_question?
    end

    answers = question.answers
    answers.each do |a|
      email = a.user.email
      if email.present? and email != answer.user.email and !emails.include? email
        emails << email
        NotificationMailer.notify_answer(email, answer).deliver if a.user.after_question_answer?
      end
    end
  end
end
