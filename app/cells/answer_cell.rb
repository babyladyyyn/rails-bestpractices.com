class AnswerCell < Cell::Rails
  include CanCan::ControllerAdditions
  include Devise::Controllers::Helpers

  cache :show do |cell, question|
    "#{question.model_cache_key}/#{question.answers_count}"
  end

  cache :new, :if => proc { |cell, question, answer, user| answer.errors.empty? } do |cell, question|
    question.model_cache_key
  end

  def show(question, user)
    @question, @answers, @user = question, question.answers, user
    if @answers.present?
      render
    end
  end

  def new(question, answer, user)
    @question, @answer, @user = question, answer, user
    if @user
      render
    else
      render :text => "<a class='answer-login-link' href='/users/sign_in'>Please login before answering the question!</a>"
    end
  end

end
