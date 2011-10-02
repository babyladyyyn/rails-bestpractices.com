class JobSweeper < ActionController::Caching::Sweeper
  observe Job

  def after_save(model)
    expire_cache_for model
  end

  def after_destroy(model)
    expire_cache_for model
  end

  private
    def expire_cache_for(job)
      expire_action :controller => "jobs", :action => "show", :id => job.id
    end
end
