class QuestionsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, :only => [:new, :edit, :create, :update, :destroy]
  has_scope :not_answered

  def show
    @question = Question.find_cached(params[:id])
    Question.increment_counter(:view_count, @question.id)
    @answer = @question.answers.build(:answer_body => AnswerBody.new)
  end

  def index
    @questions = Question.order(nav_order).paginate(page: params[:page] || 1)
    @questions = @questions.where(:answers_count => 0) if params[:nav] == 'not_answered'
  end

  def new
    @question = Question.new
    @question.build_question_body
  end

  def create
    @question = current_user.questions.build(resource_params)
    if @question.save
      flash[:notice] = "Your Question was successfully created!"
      redirect_to @question
    else
      render 'new'
    end
  end

  def edit
    @question = current_user.questions.find(params[:id])
  end

  def update
    @question = current_user.questions.find(params[:id])
    if @question.update_attributes(resource_params)
      flash[:notice] = "Your Question was successfully updated!"
      redirect_to @question
    else
      render 'edit'
    end
  end

  def resource_params
    params.require(:question).permit(:title, :tag_list, question_body_attributes: [:body]) if params[:question]
  end

  protected
    def nav_order
      params[:nav] = "id" unless %w(id vote_points answers_count not_answered).include?(params[:nav])
      params[:order] = "desc" unless %w(desc asc).include?(params[:order])
      "questions.#{params[:nav] == "not_answered" ? "id" : params[:nav]} #{params[:order]}"
    end
end
