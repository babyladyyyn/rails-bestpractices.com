class UsersController < Devise::RegistrationsController
  before_action :authenticate_user!, :only => [:edit, :update]

  def index
    @users = User.order("(posts_count * 10 + answers_count * 8 + questions_count * 4 + comments_count * 2 + votes_count) desc").limit(50)
  end

  def show
    @user = User.find_cached(params[:id])
    if params[:id] != @user.to_param
      redirect_to user_path(@user), :status => 301
    else
      params[:nav] ||= "posts"
      nav = case params[:nav]
            when "questions" then "questions"
            when "answers" then "answers"
            else "posts"
            end
      @children = @user.send(nav)
      @children = @children.published if nav == "posts"
    end
  end

  def create
    super
    session[:omniauth] = nil unless @user.new_record?
  end

  def edit
    NotificationSetting::ITEMS.each do |name, description|
      current_user.notification_settings.find_or_create_by(name: name)
    end
  end

  def update
    return create unless current_user
    if current_user.update_attributes(account_update_params)
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
      @user
    end
end
