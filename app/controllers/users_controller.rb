class UsersController < Devise::RegistrationsController
  before_filter :authenticate_user!, :only => [:edit, :update]

  def index
    @users = User.order("(posts_count * 10 + answers_count * 8 + questions_count * 4 + comments_count * 2 + votes_count) desc").limit(50)
  end

  def show
    @user = User.find_cached(params[:id])
    if params[:id] != @user.to_param
      redirect_to user_path(@user), :status => 301
    else
      params[:nav] = params[:nav] || "posts"
      @children = @user.send(params[:nav])
      @children = @children.published if params[:nav] == "posts"
    end
  end

  def create
    super
    session[:omniauth] = nil unless @user.new_record?
  end

  def edit
    NotificationSetting::ITEMS.each do |name, description|
      current_user.notification_settings.find_or_create_by_name(name)
    end
  end

  def update
    return create unless current_user
    if current_user.update_attributes(resource_params)
      redirect_to current_user, notice: "Account updated."
    else
      render :edit
    end
  end

  protected
    def build_resource(*args)
      super
      if session[:omniauth]
        @user.apply_omniauth(session[:omniauth])
        @user.valid?
      end
    end

    def resource_params
      params.require(:user).permit(:login, :email, :password, :password_confirmation)
    end
end
