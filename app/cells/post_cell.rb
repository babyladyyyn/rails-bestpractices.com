class PostCell < Cell::Rails
  cache :related do |cell, post|
    post.model_cache_key
  end

  def related(post)
    @post = post
    render
  end

end
