class PostsController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!, :only => [:new, :edit, :create, :update, :destroy]
  before_filter :set_post_order, :only => :index
  has_scope :implemented
  respond_to :xml, :only => :index

  def show
    @post = Post.find_cached(params[:id])
    if params[:id] != @post.to_param
      redirect_to post_path(@post), :status => 301
      return false
    end
    Post.increment_counter(:view_count, @post.id)
  end

  def index
    @posts = Post.published.order(nav_order).paginate(page: params[:page] || 1)
    @posts = @posts.implemented if params[:nav] == 'implemented'
  end

  def new
    @post = Post.new
    @post.build_post_body
  end

  def create
    @post = current_user.posts.build(resource_params)
    if @post.save
      redirect_to posts_path, notice: "Your Best Practice has been submitted and is pending approval."
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find_cached(params[:id])
  end

  def update
    @post = Post.find_cached(params[:id])
    if @post.update_attributes(resource_params)
      redirect_to @post, notice: "Your Best Practice was successfully updated!"
    else
      render 'edit'
    end
  end

  def archive
    @posts = Post.published
  end

  def resource_params
    params.require(:post).permit(:title, :description, :tag_list, post_body_attributes: [:body]) if params[:post]
  end

  protected
    def nav_order
      params[:nav] = "id" unless %w(id vote_points implemented).include?(params[:nav])
      params[:order] = "desc" unless %w(desc asc).include?(params[:order])
      "posts.#{params[:nav] == 'implemented' ? 'id' : params[:nav]} #{params[:order]}"
    end

    def set_post_order
      session[:post_order] = params[:nav] || "id"
    end
end
