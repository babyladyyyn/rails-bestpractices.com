class AvatarCell < Cell::Rails
  cache :show do |cell, user, size|
    if user
      "#{user.cache_key}/avatar/show/#{size}"
    else
      "avatar/show/#{size}"
    end
  end

  def show(user=nil, size=32)
    @user, @size = user, size
    render
  end

end
