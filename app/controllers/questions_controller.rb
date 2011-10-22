class QuestionsController < InheritedResources::Base
  load_and_authorize_resource
  before_filter :authenticate_user!, :only => [:new, :edit, :create, :update, :destroy]
  has_scope :not_answered

  def new
    @question = Question.new
    @question.build_question_body
  end

  show! do |format|
    Question.increment_counter(:view_count, @question.id)
    @answer = @question.answers.build(:answer_body => AnswerBody.new)
  end

  protected
    def begin_of_association_chain
      current_user
    end

    def resource
      @question = params[:action] == "update" ? Question.find(params[:id]) : Question.find_cached(params[:id])
    end

    def collection
      @questions = Question.order(nav_order).page(params[:page] || 1)
      @questions = @questions.where(:answers_count => 0) if params[:nav] == 'not_answered'
    end

    def nav_order
      params[:nav] = "id" unless %w(id vote_points answers_count not_answered).include?(params[:nav])
      params[:order] = "desc" unless %w(desc asc).include?(params[:order])
      "questions.#{params[:nav] == "not_answered" ? "id" : params[:nav]} #{params[:order]}"
    end
end
