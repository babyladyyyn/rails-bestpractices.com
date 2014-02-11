class AnswersController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, :only => :create
  before_action :load_question

  def create
    @answer = current_user.answers.build(resource_params.merge(:question_id => @question.id))
    if @answer.save
      NotifyAnswerWorker.perform_async @answer.id
      redirect_to @question, notice: "Your Answer was successfully created!"
    else
      render 'questions/show'
    end
  end

  def resource_params
    params.require(:answer).permit(answer_body_attributes: [:body]) if params[:answer]
  end

  protected
    def load_question
      @question = Question.find_cached(params[:question_id])
    end
end
