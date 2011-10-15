class PostDecorator < ApplicationDecorator
  decorates :post

  def statistics
    h.content_tag(:p, "#{vote_points} votes") +
      h.content_tag(:p, "#{comments_count} comments") +
      h.content_tag(:p, "#{view_count} views")
  end

  def link
    h.link_to title, h.post_path(model)
  end

  def implemented_icon
    if implemented?
      h.content_tag :span, "implemented", :class => "implemented"
    end
  end
end
