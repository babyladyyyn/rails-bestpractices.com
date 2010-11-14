class CommentsController < InheritedResources::Base
  actions :create, :index
  belongs_to :question, :answer, :post, :polymorphic => true, :optional => true

  def create
    @comment = parent.comments.new(params[:comment].merge(:user => current_user))
    if current_user or params[:skip] == 'true' or verify_recaptcha(:model => @comment, :message => @comment.body)
      create! do |success, failure|
        success.html {
          job = Delayed::Job.enqueue(DelayedJob::NotifyComment.new(@comment.id))
          redirect_to parent_url
        }
        failure.html { render failure_page }
      end
    else
      flash[:error] = "Not correct captcha!"
      flash.delete :recaptcha_error
      render failure_page
    end
  end

  def index
    if params[:post]
      @comments = Comment.post.includes(:user).paginate(:page => params[:page], :per_page => Comment.per_page)
    end
  end

  private
    def parent
      if params[:question_id]
        @question = Question.find(params[:question_id])
      elsif params[:answer_id]
        @answer = Answer.find(params[:answer_id])
      elsif params[:post_id]
        @post = Post.find(params[:post_id])
      end
    end

    def parent_url
      if params[:question_id]
        question_path(@question)
      elsif params[:answer_id]
        question_path(@answer.question)
      elsif params[:post_id]
        post_path(@post)
      end
    end
    
    def failure_page
      if params[:question_id]
        'questions/show'
      elsif params[:answer_id]
        'questions/show'
      elsif params[:post_id]
        'posts/show'
      end
    end
end
