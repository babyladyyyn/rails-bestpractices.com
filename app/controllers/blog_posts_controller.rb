class BlogPostsController < InheritedResources::Base
  respond_to :xml, :only => :index

  def show
    show! do |format|
      @comment = @blog_post.comments.build
    end
  end

  protected
    def collection
      @blog_posts ||= end_of_association_chain.order("created_at desc").paginate(:page => params[:page], :per_page => BlogPost.per_page)
    end
end
