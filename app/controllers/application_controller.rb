class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render_404
  end

  rescue_from ActionController::InvalidAuthenticityToken do |exception|
    render_422
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:login, :email, :password, :password_confirmation) }
      devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :email) }
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:login, :email, :password, :password_confirmation, :url, :notification_settings_attributes) }
    end

    def render_404(exception = nil)
      if exception
        logger.info "Rendering 404 with exception: #{exception.message}"
      end

      respond_to do |format|
        format.html { render :file => "#{Rails.root}/public/404", :formats => [:html], :status => :not_found, :layout => false }
        format.xml  { head :not_found }
        format.any  { head :not_found }
      end
    end

    def render_422(exception = nil)
      if exception
        logger.info "Rendering 422 with exception: #{exception.message}"
      end

      respond_to do |format|
        format.html { render :file => "#{Rails.root}/public/422", :formats => [:html], :status => :unprocessable_entity, :layout => false }
        format.xml  { header :unprocessable_entity }
        format.any  { header :unprocessable_entity }
      end
    end
end
