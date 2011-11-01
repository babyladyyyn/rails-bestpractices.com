class VoteSweeper < ActionController::Caching::Sweeper
  observe Vote

  def after_create(vote)
    Rails.cache.delete "cells/vote/up/#{vote.cached_voteable.model_cache_key}/#{vote.cached_user.model_cache_key}"
    Rails.cache.delete "cells/vote/down/#{vote.cached_voteable.model_cache_key}/#{vote.cached_user.model_cache_key}"
    true
    # expire_cell_state VoteCell, :show, [vote.cached_voteable.model_cache_key, vote.cached_user.model_cache_key]
  end

  def before_destroy(vote)
    Rails.cache.delete "cells/vote/up/#{vote.cached_voteable.model_cache_key}/#{vote.cached_user.model_cache_key}"
    Rails.cache.delete "cells/vote/down/#{vote.cached_voteable.model_cache_key}/#{vote.cached_user.model_cache_key}"
    true
    # expire_cell_state VoteCell, :show, [vote.cached_voteable.model_cache_key, vote.cached_user.model_cache_key]
  end
end
