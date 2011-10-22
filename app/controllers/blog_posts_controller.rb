class BlogPostsController < InheritedResources::Base
  respond_to :xml, :only => :index

  def show
    show! do |format|
      @comment = @blog_post.comments.build
    end
  end

  protected
    def resource
      @blog_post = BlogPost.find_cached(params[:id])
    end

    def collection
      @blog_posts = BlogPost.order("created_at desc").page(params[:page] || 1)
    end
end
