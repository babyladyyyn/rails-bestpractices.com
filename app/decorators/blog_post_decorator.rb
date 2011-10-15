class BlogPostDecorator < ApplicationDecorator
  decorates :blog_post

  def link
    h.link_to model.title, h.blog_post_path(model)
  end

  def comments_count_link
    h.link_to "#{model.comments_count} Comments", h.blog_post_path(model, :anchor => "comments")
  end
end
