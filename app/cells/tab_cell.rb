class TabCell < Cell::Rails
  helper_method :nav_class, :nav_title, :nav_order, :nav_order_class

  cache :post do |cell|
    "#{cell.params[:nav]}/#{cell.params[:order]}"
  end

  cache :question do |cell|
    "#{cell.params[:nav]}/#{cell.params[:order]}"
  end

  cache :tag do |cell|
    cell.params[:nav]
  end

  cache :user do |cell, user|
    if user
      "users/#{user.id}/#{cell.params[:nav]}"
    else
      cell.params[:nav]
    end
  end

  def post
    render
  end

  def question
    render
  end

  def tag(tag)
    @tag = tag
    render
  end

  def user(user)
    @user = user
    render
  end

  def nav_class(name)
    params[:nav] == name ? "nav active" : "nav"
  end

  def nav_title(name)
    case name
    when "id"
      "Created"
    when "vote_points"
      "Votes"
    when "comments_count"
      "Comments"
    when "answers_count"
      "Answers"
    end
  end

  def nav_order(name)
    if params[:nav] == name
      params[:order] == "asc" ? "desc" : "asc"
    else
      "desc"
    end
  end

  def nav_order_class(name)
    class_name = nav_order(name) == "desc" ? "arrow-up-icon" : "arrow-down-icon"
    if params[:nav] == name
      "#{name} #{class_name}"
    else
      name
    end
  end
end
