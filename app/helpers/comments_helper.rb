module CommentsHelper
  def comment_user_link(comment)
    if comment.cached_user
      link_to comment.cached_user.login, user_path(comment.cached_user)
    else
      comment.username
    end
  end

  def comment_parent_link(comment)
    commentable = comment.cached_commentable
    case commentable
    when Post
      post_path(commentable)
    when Question
      question_path(commentable)
    when Answer
      question_path(commentable.cached_question)
    when BlogPost
      blog_post_path(commentable)
    end
  end
end
