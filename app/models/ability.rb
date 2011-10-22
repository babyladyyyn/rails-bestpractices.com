class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :read, :all
    can :manage, Job, :user_id => user.id
    can :manage, Post, :user_id => user.id
    can :manage, Question, :user_id => user.id
    can :manage, Answer, :user_id => user.id

    if user.admin?
      can :access, :rails_admin
      can :manage, :all
    end
  end
end
