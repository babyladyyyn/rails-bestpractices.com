class JobsController < InheritedResources::Base
  before_filter :authenticate_user!, :only => [:new, :edit, :created, :update]

  protected
    def collection
      @jobs = Job.page(params[:page].to_i)
    end
end
