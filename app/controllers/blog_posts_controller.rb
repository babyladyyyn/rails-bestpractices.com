class BlogPostsController < InheritedResources::Base
  respond_to :xml, :only => :index
  before_filter :load_recent_blog_posts

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
      @blog_posts ||= BlogPost.order("created_at desc").page(params[:page].to_i)
    end

    def load_recent_blog_posts
      @recent_blog_posts = BlogPost.order("created_at desc").select("id, title").limit(10)
    end
end
