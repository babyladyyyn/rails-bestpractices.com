class VoteCell < Cell::Rails
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
