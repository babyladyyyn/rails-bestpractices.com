class PostCell < Cell::Rails
  cache :related do |cell, post|
    "#{post.cache_key}/post/related"
  end

  def related(post)
    @related_posts = post.related_posts
    render
  end

end
