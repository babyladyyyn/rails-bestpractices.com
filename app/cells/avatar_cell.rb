class AvatarCell < Cell::Rails
  cache :show do |cell, user, size|
    if user
      "#{user.model_cache_key}/#{size}"
    else
      size
    end
  end

  def show(user=nil, size=32)
    @user, @size = user, size
    render
  end

end
