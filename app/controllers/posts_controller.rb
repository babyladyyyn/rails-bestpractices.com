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

  show! do |format|
    @post.increment!(:view_count)
    @comment = @post.comments.build
  end
  
  def archive
    @posts = Post.all
  end
  
  protected
    def begin_of_association_chain
      @current_user
    end
    
    def collection
      @posts ||= end_of_association_chain.includes(:user, :tags)
      @posts = @posts.order(params[:order] ? "#{params[:nav]} #{params[:order]}" : "created_at desc")
      @posts = @posts.paginate(:page => params[:page], :per_page => Post.per_page)
    end
end
