class CommentDecorator < ApplicationDecorator
  decorates :comment

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
      h.link_to "Post #{commentable.title}",  h.post_url(commentable)
    when Question
      h.link_to "Question #{commentable.title}", h.question_url(commentable)
    when Answer
      h.link_to "Answer of #{commentable.cached_question.title}", h.question_url(commentable.cached_question)
    when BlogPost
      h.link_to "Blog Post #{commentable.title}", h.blog_post_url(commentable)
    end
  end
end
