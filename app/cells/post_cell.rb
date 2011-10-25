class PostCell < Cell::Rails
  cache :related do |cell, post|
    post.model_cache_key
  end

  cache :prev_next do |cell, post|
    post.model_cache_key
  end

  def related(post)
    @related_posts = post.related_posts
    render
  end

  def prev_next(post)
    @prev_post = post.prev
    @next_post = post.next
    render
  end

end
