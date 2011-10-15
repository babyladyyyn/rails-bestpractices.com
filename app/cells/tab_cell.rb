class TabCell < Cell::Rails
  helper_method :nav_class, :nav_title, :nav_order, :nav_order_class

  def post
    render
  end

  def nav_class(name)
    params[:nav] == name ? "nav active" : "nav"
  end

  def nav_title(name)
    case name
    when "created_at"
      "Created"
    when "vote_points"
      "Votes"
    when "comments_count"
      "Comments"
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
