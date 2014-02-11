class JobsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, :only => [:new, :edit, :created, :update]
  before_action :require_partner, :only => :partner
  respond_to :xml, :only => :index

  def show
    @job = Job.find_cached(params[:id])
  end

  def index
    @jobs = Job.published.order('created_at desc').paginate(page: params[:page] || 1)
  end

  def new
    @job = Job.new
  end

  def create
    @job = current_user.jobs.build(resource_params)
    if @job.save
      redirect_to jobs_path, notice: "Your Job has been submitted and is pending approval."
    else
      render 'new'
    end
  end

  def edit
    @job = Job.find_cached(params[:id])
  end

  def update
    @job = Job.find_cached(params[:id])
    if @job.update_attributes(resource_params)
      redirect_to @job, notice: "Your Job was successfully updated!"
    else
      render 'edit'
    end
  end

  def partner
    @jobs = Job.published.owner.order('created_at desc').where(["id > ?", params["last_id"].to_i])
    render :xml => @jobs.to_xml(:methods => :cached_job_type_names)
  end

  def resource_params
    params.require(:job).permit(:title, :company, :company_url, :country, :state, :city, :address, :salary, :apply_email, :description, :job_type_ids) if params[:job]
  end

  protected
    def require_partner
      @partner = JobPartner.find_by_token(params[:token])
      render_422 and return unless @partner
    end
end
