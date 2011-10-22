class VoteCell < Cell::Rails
  cache :show do |cell, voteable, user|
    if user
      "#{voteable.model_cache_key}/#{user.model_cache_key}"
    else
      voteable.model_cache_key
    end
  end

  def show(voteable, user)
    @voteable = voteable
    @user = user
    if user
      @vote = voteable.vote(user)
    end
    render
  end

end
