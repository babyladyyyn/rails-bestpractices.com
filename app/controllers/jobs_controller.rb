class JobsController < InheritedResources::Base
  load_and_authorize_resource
  before_filter :authenticate_user!, :only => [:new, :edit, :created, :update]
  before_filter :require_partner, :only => :partner
  respond_to :xml, :only => :index

  create! do |success, failure|
    success.html { redirect_to posts_path }
    failure.html { render :new }
  end

  def partner
    @jobs = Job.published.order('created_at desc').where(["id > ?", params["last_id"].to_i])
    render :xml => @jobs.to_xml
  end

  protected
    def begin_of_association_chain
      current_user
    end

    def resource
      @job = Job.find(params[:id])
    end

    def collection
      @jobs = Job.published.order('created_at desc').page(params[:page].to_i)
    end

    def require_partner
      @partner = JobPartner.find_by_token(params[:token])
      render_422 and return unless @partner
    end
end
