class JobsController < InheritedResources::Base
  before_filter :authenticate_user!, :only => [:new, :edit, :created, :update]
  respond_to :xml, :only => :index

  create! do |success, failure|
    success.html { redirect_to posts_path }
    failure.html { render :new }
  end

  protected
    def collection
      @jobs = Job.published.page(params[:page].to_i)
    end
end
