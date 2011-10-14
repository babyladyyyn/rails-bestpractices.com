class CommentDecorator < ApplicationDecorator
  decorates :comment

  def user_link
    if model.cached_user
      h.link_to model.cached_user.login, h.user_path(model.cached_user)
    else
      model.username
    end
  end

  def user_avatar
    if model.cached_user
      h.image_tag model.cached_user.gravatar_url(:size => 32, :default => 'mm'), :class => 'user-avatar', :alt => model.cached_user.login
    else
      default_gravatar
    end
  end

  def user_name
    cached_user ? cached_user.login : username
  end

  def user_email
    cached_user ? cached_user.email : email
  end

  def parent_link
    commentable = model.cached_commentable
    case commentable
    when Post
      h.post_url(commentable)
    when Question
      h.question_url(commentable)
    when Answer
      h.question_url(commentable.cached_question)
    when BlogPost
      h.blog_post_path(commentable)
    end
  end

  def parent_name
    commentable = model.cached_commentable
    case commentable
    when Question
      "Question #{commentable.title}"
    when Answer
      "Answer of #{commentable.cached_question.title}"
    when Post
      "Post #{commentable.title}"
    when BlogPost
      "Blog Post #{commentable.title}"
    end
  end
end
