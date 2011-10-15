class CommentDecorator < ApplicationDecorator
  include WhiteListHelper
  decorates :comment

  def user_name
    cached_user ? cached_user.login : username
  end

  def user_email
    cached_user ? cached_user.email : email
  end

  def parent_name
    commentable = model.cached_commentable
    case commentable
    when Post
      "Post #{commentable.title}"
    when Question
      "Question #{commentable.title}"
    when Answer
      "Answer of #{commentable.cached_question.title}"
    when BlogPost
      "Blog Post #{commentable.title}"
    end
  end

  def parent_link
    commentable = model.cached_commentable
    case commentable
    when Post
      h.link_to "Post #{commentable.title}", h.post_url(commentable)
    when Question
      h.link_to "Question #{commentable.title}", h.question_url(commentable)
    when Answer
      h.link_to "Answer of #{commentable.cached_question.title}", h.question_url(commentable.cached_question)
    when BlogPost
      h.link_to "Blog Post #{commentable.title}", h.blog_post_url(commentable)
    end
  end

  def wikistyle_body
    white_list(model.body.gsub("\n", "<br/>"), :tags => %w(a b blockquote pre code em i strong), :attributes => %w(title href)).html_safe
  end
end
