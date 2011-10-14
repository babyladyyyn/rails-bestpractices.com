class BlogPostCell < Cell::Rails
  cache :recent, :expires_in => 1.day

  def recent
    @recent_blog_posts = BlogPost.order("created_at desc").select("id, title").limit(10)
    render
  end

end
