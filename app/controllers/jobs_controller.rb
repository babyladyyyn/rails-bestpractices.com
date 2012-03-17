class JobsController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!, :only => [:new, :edit, :created, :update]
  before_filter :require_partner, :only => :partner
  respond_to :xml, :only => :index

  def show
    @job = Job.find_cached(params[:id])
  end

  def index
    @jobs = Job.published.order('created_at desc').page(params[:page] || 1)
  end

  def new
    @job = Job.new
  end

  def create
    @job = current_user.jobs.build(params[:job])
    if @job.save
      redirect_to jobs_path, notice: "Your Job has been submitted and is pending approval."
    else
      render 'new'
    end
  end

  def edit
    @job = current_user.jobs.find(params[:id])
  end

  def update
    @job = current_user.jobs.build(params[:job])
    if @job.save
      redirect_to @job, notice: "Your Job was successfully updated!"
    else
      render 'edit'
    end
  end

  def partner
    @jobs = Job.published.owner.order('created_at desc').where(["id > ?", params["last_id"].to_i])
    render :xml => @jobs.to_xml(:methods => :cached_job_type_names)
  end

  protected
    def require_partner
      @partner = JobPartner.find_by_token(params[:token])
      render_422 and return unless @partner
    end
end
