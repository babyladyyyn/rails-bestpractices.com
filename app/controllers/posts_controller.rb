class PostsController < InheritedResources::Base
  before_filter :require_user, :only => [:new, :edit, :create, :update, :destroy]
  has_scope :implemented
  respond_to :xml, :only => :index

  def new
    if params[:answer_id]
      @post = Answer.find(params[:answer_id]).to_post
    else
      @post = Post.new
    end
  end

  index! do |format|
    params[:nav] ||= "created_at"
    params[:order] ||= "desc"
  end

  def show
    @post = Post.published.find(params[:id])
    if params[:id] != @post.to_param
      redirect_to post_path(@post), :status => 301
      return false
    end
    show! do |format|
      @post.increment!(:view_count)
      @comment = @post.comments.build
    end
  end

  create! do |success, failure|
    success.html { redirect_to posts_path }
    failure.html { render :new }
  end

  def archive
    @posts = Post.published
  end

  protected
    def begin_of_association_chain
      @current_user
    end

    def collection
      @posts ||= end_of_association_chain.published.includes(:user, :tags)
      @posts = @posts.order(params[:order] ? "#{params[:nav]} #{params[:order]}" : "created_at desc")
      @posts = @posts.paginate(:page => params[:page], :per_page => Post.per_page)
    end
end
