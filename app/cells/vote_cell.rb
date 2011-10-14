class VoteCell < Cell::Rails

  def show(voteable)
    @voteable = voteable
    render
  end

end
