class JobsController < InheritedResources::Base
  before_filter :authenticate_user!, :only => [:new, :edit, :created, :update]
  respond_to :xml, :only => :index
  load_and_authorize_resource

  create! do |success, failure|
    success.html { redirect_to posts_path }
    failure.html { render :new }
  end

  protected
    def begin_of_association_chain
      current_user
    end

    def resource
      @job = Job.find(params[:id])
    end

    def collection
      @jobs = Job.published.page(params[:page].to_i)
    end
end
