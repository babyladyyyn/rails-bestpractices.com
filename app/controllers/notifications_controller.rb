class NotificationsController < InheritedResources::Base
  actions :index, :destroy
  before_filter :require_user
  after_filter :mark_as_read, :only => :index

  protected
    def mark_as_read
      @notifications.each do |notification|
        notification.read! unless notification.read?
      end
    end

    def begin_of_association_chain
      @current_user
    end
    
    def collection
      @notifications ||= end_of_association_chain.paginate(:page => params[:page], :per_page => Notification.per_page)
    end
end
