class VoteCell < Cell::Rails
  cache :show do |cell, voteable, user|
    "#{voteable.model_cache_key}/#{user.model_cache_key}"
  end

  def show(voteable, user)
    @voteable = voteable
    @user = user
    render
  end

end
