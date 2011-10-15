module ApplicationHelper

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
