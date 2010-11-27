module ApplicationHelper
  def display_chinese_entry?
    current_locale == 'zh' and 'false' != cookies[:chinese_entry] and params[:controller] == 'posts' and params[:action] == 'index'
  end

  def current_locale
    request.env['HTTP_ACCEPT_LANGUAGE'] ? request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first : "en"
  end

  def nav_class(name, &block)
    class_name = if params[:nav] == name
      "nav active"
    else
      "nav"
    end
    content_tag(:li, :class => class_name, &block)
  end

  def posts_order_link(name)
    title = case name
            when "created_at"
              "Created"
            when "vote_points"
              "Votes"
            when "comments_count"
              "Comments"
            end
    order = params[:order] == "desc" ? "asc" : "desc"
    class_name = order == "desc" ? "arrow-up-icon" : "arrow-down-icon"
    if params[:nav] == name
      link_to title, posts_path(:nav => name, :order => order), :class => "#{name} #{class_name}"
    else
      link_to title, posts_path(:nav => name, :order => "desc"), :class => "#{name}"
    end
  end

  def questions_order_link(name)
    title = case name
            when "created_at"
              "Created"
            when "vote_points"
              "Votes"
            when "answers_count"
              "Answers"
            end
    order = params[:order] == "desc" ? "asc" : "desc"
    class_name = order == "desc" ? "arrow-up-icon" : "arrow-down-icon"
    if params[:nav] == name
      link_to title, questions_path(:nav => name, :order => order), :class => "#{name} #{class_name}"
    else
      link_to title, questions_path(:nav => name, :order => "desc"), :class => "#{name}"
    end
  end
end
