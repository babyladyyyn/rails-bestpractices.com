class VoteCell < Cell::Rails
  cache :up do |cell, voteable, user|
    if user
      "#{voteable.model_cache_key}/#{user.model_cache_key}"
    else
      voteable.model_cache_key
    end
  end

  cache :down do |cell, voteable, user|
    if user
      "#{voteable.model_cache_key}/#{user.model_cache_key}"
    else
      voteable.model_cache_key
    end
  end

  def show(voteable, user)
    @voteable = voteable
    @user = user
    render
  end

  def up(voteable, user)
    @voteable = voteable
    @user = user
    if user
      @vote = voteable.vote(user)
    end
    render
  end

  def down(voteable, user)
    @voteable = voteable
    @user = user
    if user
      @vote = voteable.vote(user)
    end
    render
  end

end
