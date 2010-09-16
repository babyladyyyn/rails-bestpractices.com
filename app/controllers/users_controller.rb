class UsersController < ApplicationController
  before_filter :require_user, :only => [:edit, :update]
  
  def index
    @users = User.order("(posts_count * 10 + answers_count * 8 + questions_count * 4 + comments_count * 2 + votes_count) desc").limit(50)
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    # block! see user_sessions_controller.rb for description
    @user.save do |result|
      if result
        flash[:notice] = "Register successful!"
        redirect_back_or_default root_url
      else
        render :action => :new
      end
    end
  end

  def show
    @user = User.find(params[:id])
    if params[:id] != @user.to_param
      redirect_to user_path(@user), :status => 301 
    else
      params[:nav] = params[:nav] || "posts"
      @children = @user.send(params[:nav])
    end
  end

  def edit
    @user = @current_user
  end

  def update
    return create unless @current_user
    @user = @current_user # makes our views "cleaner" and more consistent
    @user.update_attributes(params[:user]) do |result|
      if result
        flash[:notice] = "Account updated!"
        redirect_to :action => :show
      else
        render :action => :edit
      end
    end
  end
end
