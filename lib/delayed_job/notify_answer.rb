class DelayedJob::NotifyAnswer < Struct.new(:answer_id)
  def perform
    answer = Answer.find(answer_id)
    question = answer.question
    emails = []

    email = question.user.email
    if email and question.user != answer.user
      emails << email
      NotificationMailer.notify_answer(email, answer).deliver
    end

    answers = question.answers
    answers.each do |a|
      email = a.user.email
      if email and email != answer.user.email and !emails.include? email
        emails << email
        NotificationMailer.notify_answer(email, answer).deliver
      end
    end
  end
end
