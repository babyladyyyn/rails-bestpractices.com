class PostCell < Cell::Rails
  cache :related do |cell, post|
    post.model_cache_key
  end

  cache :prev_next, :if => proc { |cell, post| !cell.session[:post_order] || cell.session[:post_order] == "id" } do |cell, post|
    post.model_cache_key
  end

  def related(post)
    @related_posts = post.related_posts
    render
  end

  def prev_next(post)
    @prev_post = post.prev(session[:post_order] || "id")
    @next_post = post.next(session[:post_order] || "id")
    render
  end

end
