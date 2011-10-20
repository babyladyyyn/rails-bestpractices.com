class AvatarCell < Cell::Rails

  def show(user=nil, size=32)
    @user, @size = user, size
    render
  end

end
