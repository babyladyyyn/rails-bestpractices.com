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
      @questions = @questions.order("#{nav} #{order}")
      @questions = @questions.paginate(:page => params[:page], :per_page => Question.per_page)
    end

    def nav
      params[:nav] = "created_at" unless %w(created_at vote_points answers_count not_answered).include?(params[:nav])
      params[:nav]
    end

    def order
      params[:order] = "desc" unless %w(desc asc).include?(params[:order])
      params[:order]
    end
end
