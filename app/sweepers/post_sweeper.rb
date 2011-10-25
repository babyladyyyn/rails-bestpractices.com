class PostSweeper < ActionController::Caching::Sweeper
  observe Post

  def after_create(post)
    Rails.cache.delete "cells/post/prev_next/#{post.prev.model_cache_key}"
  end
end
