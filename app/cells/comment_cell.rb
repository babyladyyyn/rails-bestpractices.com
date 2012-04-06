class CommentCell < Cell::Rails
  cache :show do |cell, parent|
    parent.cache_key
  end

  cache :show_short do |cell, parent|
    parent.cache_key
  end

  def show(parent)
    @comments = parent.comments
    render if @comments.present?
  end

  def show_short(parent)
    @comments = parent.comments
    render if @comments.present?
  end

  def new(parent, comment, user)
    @parent, @user = parent, user
    @comment = comment || parent.comments.build
    render
  end

  def new_short(parent, user)
    @parent, @user = parent, user
    @comment = parent.comments.build
    render
  end

end
