class VoteCell < Cell::Rails
  include Devise::Controllers::Helpers

  def show(voteable)
    @voteable = voteable
    @user = current_user
    render
  end

end
