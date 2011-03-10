class NotificationsController < InheritedResources::Base
  actions :index, :destroy
  before_filter :authenticate_user!
  after_filter :mark_as_read, :only => :index

  protected
    def mark_as_read
      @notifications.each do |notification|
        notification.read! unless notification.read?
      end
    end

    def begin_of_association_chain
      current_user
    end

    def collection
      @notifications ||= end_of_association_chain.page(params[:page].to_i)
    end
end
