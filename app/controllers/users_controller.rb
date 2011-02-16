class UsersController < Devise::RegistrationsController
  before_filter :authenticate_user!, :only => [:edit, :update]

  def index
    @users = User.order("(posts_count * 10 + answers_count * 8 + questions_count * 4 + comments_count * 2 + votes_count) desc").limit(50)
  end

  def show
    @user = User.find(params[:id])
    if params[:id] != @user.to_param
      redirect_to user_path(@user), :status => 301
    else
      params[:nav] = params[:nav] || "posts"
      @children = @user.send(params[:nav])
      @children = @children.published if params[:nav] == "posts"
    end
  end

  def edit
    @user = current_user
    NotificationSetting::ITEMS.each do |name, description|
      @user.notification_settings.find_or_create_by_name(name)
    end
  end

  def update
    return create unless current_user
    @user = current_user # makes our views "cleaner" and more consistent
    @user.update_attributes(params[:user]) do |result|
      if result
        flash[:notice] = "Account updated!"
        redirect_to :action => :edit
      else
        render :edit
      end
    end
  end
end
