class BlogPostsController < ApplicationController
  respond_to :xml, :only => :index

  def show
    @blog_post = BlogPost.find_cached(params[:id])
  end

  def index
    @blog_posts = BlogPost.order("created_at desc").paginate(page: params[:page] || 1)
  end
end
