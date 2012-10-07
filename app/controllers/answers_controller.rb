class AnswersController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!, :only => [:new, :edit, :create, :update, :destroy]
  before_filter :load_question

  def create
    @answer = current_user.answers.build(resource_params.merge(:question_id => @question.id))
    if @answer.save
      job = Delayed::Job.enqueue(DelayedJob::NotifyAnswer.new(@answer.id))
      redirect_to @question, notice: "Your Answer was successfully created!"
    else
      render 'questions/show'
    end
  end

  def edit
    @answer = Answer.find_cached(params[:id])
  end

  def update
    @answer = Answer.find_cached(params[:id])
    if @answer.update_attributes(resource_params)
      redirect_to @question, notice: "Your Answer was successfully updated!"
    else
      render 'questions/show'
    end
  end

  protected
    def resource_params
      params.require(:answer).permit(answer_body_attributes: [:body]) if params[:answer]
    end

    def load_question
      @question = Question.find_cached(params[:question_id])
    end
end
