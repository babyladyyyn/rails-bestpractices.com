class BlogPostsController < ApplicationController
  respond_to :xml, :only => :index

  def show
    @blog_post = BlogPost.find_cached(params[:id])
    @comment = @blog_post.comments.build
  end

  def index
    @blog_posts = BlogPost.order("created_at desc").page(params[:page] || 1)
  end
end
