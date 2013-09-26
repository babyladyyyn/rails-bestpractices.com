class NotificationsController < ApplicationController
  before_action :authenticate_user!
  after_action :mark_as_read, :only => :index

  def index
    @notifications = current_user.notifications.order('notifications.created_at desc').paginate(page: params[:page] || 1)
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
