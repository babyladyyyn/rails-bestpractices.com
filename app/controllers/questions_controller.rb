class QuestionsController < InheritedResources::Base
  before_filter :authenticate_user!, :only => [:new, :edit, :create, :update, :destroy]
  has_scope :not_answered

  show! do |format|
    @question.increment!(:view_count)
    @answer = @question.answers.build
  end

  protected
    def begin_of_association_chain
      current_user
    end

    def resource
      @question = Question.find(params[:id])
    end

    def collection
      @questions = Question.includes(:user, :tags)
      @questions = @questions.where(:answers_count => 0) if params[:nav] == 'not_answered'
      @questions = @questions.order(nav_order).page(params[:page].to_i)
    end

    def nav_order
      params[:nav] = "created_at" unless %w(created_at vote_points answers_count not_answered).include?(params[:nav])
      params[:order] = "desc" unless %w(desc asc).include?(params[:order])
      "questions.#{params[:nav] == "not_answered" ? "created_at" : params[:nav]} #{params[:order]}"
    end
end
