class VoteSweeper < ActionController::Caching::Sweeper
  observe Vote

  def after_create(vote)
    Rails.cache.delete "cells/vote/show/#{vote.cached_voteable.model_cache_key}/#{vote.cached_user.model_cache_key}"
    # expire_cell_state VoteCell, :show, [vote.cached_voteable.model_cache_key, vote.cached_user.model_cache_key]
  end

  def before_destroy(vote)
    Rails.cache.delete "cells/vote/show/#{vote.cached_voteable.model_cache_key}/#{vote.cached_user.model_cache_key}"
    # expire_cell_state VoteCell, :show, [vote.cached_voteable.model_cache_key, vote.cached_user.model_cache_key]
  end
end
