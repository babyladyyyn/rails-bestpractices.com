class ApplicationDecorator < Draper::Base

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

  def vote_like_link(user)
    unless user
      return h.link_to 'Like', h.new_user_session_path(:return_to => h.polymorphic_path(model)), :class => 'like-icon'
    end
    vote = model.vote user
    if vote
      if vote.like?
        h.link_to 'Like', "javascript:alert('You have voted like this best practices!');", :class => 'like-icon active'
      else
        h.button_to 'Like', h.polymorphic_path([model, vote]), :method => :delete, :class => 'like-icon'
      end
    else
      h.button_to 'Like', h.polymorphic_path([model, :votes], :like => true), :class => 'like-icon'
    end
  end

  def vote_dislike_link(user)
    unless user
      return h.link_to 'Dislike', h.new_user_session_path(:return_to => h.polymorphic_path(model)), :class => 'dislike-icon'
    end
    vote = model.vote user
    if vote
      if vote.like?
        h.button_to 'Dislike', h.polymorphic_path([model, vote]), :method => :delete, :class => 'dislike-icon'
      else
        h.link_to 'Dislike', "javascript:alert('You have voted dislike this best practices!');", :class => 'dislike-icon active'
      end
    else
      h.button_to 'Dislike', h.polymorphic_path([model, :votes], :like => false), :class => 'dislike-icon'
    end
  end

  def default_gravatar(size = 32)
    h.image_tag "http://gravatar.com/avatar/b642b4217b34b1e8d3bd915fc65c4452.png?d=mm&r=PG&s=#{size}", :class => 'user-avatar', :alt => 'anonymous'
  end

  def created_date
    h.l created_at.to_date
  end

  def created_time
    h.l created_at
  end

  def tag_links
    links = []
    TagDecorator.decorate_each(cached_tags) do |tag|
      links << tag.link
    end
    links.join("").html_safe
  end

  def self.decorate_each(objects)
    objects.each do |object|
      yield decorate(object)
    end
  end
end
