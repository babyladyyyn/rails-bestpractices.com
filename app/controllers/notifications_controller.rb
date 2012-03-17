class NotificationsController < ApplicationController
  before_filter :authenticate_user!
  after_filter :mark_as_read, :only => :index

  def index
    @notifications = current_user.notifications.page(params[:page] || 1)
  end

  def destroy
    @notification = current_user.notifications.find(params[:id])
    @notification.destroy
    redirect_to notifications_path
  end

  protected
    def mark_as_read
      @notifications.each do |notification|
        notification.read! unless notification.read?
      end
    end
end
