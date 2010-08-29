module ApplicationHelper
  def stylesheets
    ['compiled/screen', 'compiled/layout', 'compiled/sidebar', 'compiled/post', 'compiled/question', 'compiled/answer', 'compiled/implementation', 'compiled/comment', 'compiled/user', 'compiled/notification', 'compiled/addthis', 'compiled/jquery.autocomplete', 'compiled/formtastic', 'compiled/formtastic_changes', 'compiled/login_register', 'compiled/css_sprite', 'prettify', 'compiled/page']
  end

  def javascripts
    javascripts = ['jquery', 'rails', 'jquery.autocomplete', 'prettify', 'wmd', 'application', 'uservoice']
    if Rails.env == 'production'
      javascripts << 'google_analytics'
    end
    if Rails.env == 'development'
      javascripts << ['showdown', 'wmd-base', 'wmd-plus']
    end
    javascripts
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
