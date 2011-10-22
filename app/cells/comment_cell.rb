class CommentCell < Cell::Rails
  cache :show do |cell, parent|
    "#{parent.model_cache_key}/comment/show/#{parent.comments_count}"
  end

  cache :new, :if => proc { |cell, parent, comment, user| comment.errors.empty? } do |cell, parent, comment, user|
    "#{parent.model_cache_key}/comment/new/#{!!user}"
  end

  cache :show_short do |cell, parent|
    "#{parent.model_cache_key}/comment/show_short/#{parent.comments_count}"
  end

  cache :new_short do |cell, parent, user|
    "#{parent.model_cache_key}/comment/new/#{!!user}"
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
