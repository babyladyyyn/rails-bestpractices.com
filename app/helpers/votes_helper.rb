module VotesHelper
  def vote_like_link(voteable)
    unless current_user
      return link_to 'Like', new_user_session_path(:return_to => request.url), :class => 'like-icon'
    end
    vote = voteable.vote current_user
    if vote
      if vote.like?
        link_to 'Like', "javascript:alert('You have voted like this best practices!');", :class => 'like-icon active'
      else
        button_to 'Like', polymorphic_path([voteable, vote]), :method => :delete, :class => 'like-icon'
      end
    else
      button_to 'Like', polymorphic_path([voteable, :votes], :like => true), :class => 'like-icon'
    end
  end
  
  def vote_dislike_link(voteable)
    unless current_user
      return link_to 'Dislike', new_user_session_path(:return_to => request.url), :class => 'dislike-icon'
    end
    vote = voteable.vote current_user
    if vote
      if vote.like?
        button_to 'Dislike', polymorphic_path([voteable, vote]), :method => :delete, :class => 'dislike-icon'
      else
        link_to 'Dislike', "javascript:alert('You have voted dislike this best practices!');", :class => 'dislike-icon active'
      end
    else
      button_to 'Dislike', polymorphic_path([voteable, :votes], :like => false), :class => 'dislike-icon'
    end
  end

  def voteable_link(vote)
    if vote.voteable.is_a? Answer
      question_path(vote.voteable.question)
    else
      polymorphic_path(vote.voteable)
    end
  end
end
