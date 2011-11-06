class HeaderCell < Cell::Rails
  cache :show, :if => proc { |cell, user| !user }

  def show(user)
    @user = user
    render
  end

end
