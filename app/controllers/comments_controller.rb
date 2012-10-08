class CommentsController < ApplicationController
  def create
    render_422 and return if params[:comment].blank?
    @comment = parent.comments.new(resource_params.merge(:user => current_user))
    if current_user || params[:skip] == 'true' || verify_recaptcha(:model => @comment, :message => @comment.body)
      if @comment.save
        redirect_to parent_url, notice: "Your Comment was successfully created!"
      else
        render failure_page
      end
    else
      flash.delete :recaptcha_error
      render failure_page, error: "Not correct captcha!"
    end
  end

  def index
    @comments = Comment.for_post.includes(:user).page(params[:page] || 1)
  end

  private
    def resource_params
      params.require(:comment).permit(:body, :username, :email)
    end

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
        'questions/show'
      elsif params[:answer_id]
        'questions/show'
      elsif params[:post_id]
        'posts/show'
      elsif params[:blog_post_id]
        'blog_posts/show'
      end
    end
end
