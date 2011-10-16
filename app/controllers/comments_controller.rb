class CommentsController < InheritedResources::Base
  actions :create, :index
  belongs_to :question, :answer, :post, :polymorphic => true, :optional => true

  def create
    render_422 and return if params[:comment].blank?
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
    @comments = Comment.for_post.includes(:user).page(params[:page].to_i)
  end

  private
    def parent
      if params[:question_id]
        @question = Question.find_cached(params[:question_id])
      elsif params[:answer_id]
        @answer = Answer.find_cached(params[:answer_id])
      elsif params[:post_id]
        @post = Post.find_cached(params[:post_id])
      elsif params[:blog_post_id]
        @blog_post = BlogPost.find_cached(params[:blog_post_id])
      end
    end

    def parent_url
      if params[:question_id]
        question_path(@question)
      elsif params[:answer_id]
        question_path(@answer.cached_question)
      elsif params[:post_id]
        post_path(@post)
      elsif params[:blog_post_id]
        blog_post_path(@blog_post)
      end
    end

    def failure_page
      if params[:question_id]
        @question = QuestionDecorator.new(@question)
        'questions/show'
      elsif params[:answer_id]
        @question = QuestionDecorator.new(@answer.cached_question)
        'questions/show'
      elsif params[:post_id]
        @post = PostDecorator.new(@post)
        'posts/show'
      elsif params[:blog_post_id]
        @blog_post = BlogPostDecorator.new(@blog_post)
        'blog_posts/show'
      end
    end
end
