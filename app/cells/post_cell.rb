class PostCell < Cell::Rails

  def related(post)
    @post = post
    render
  end

end
