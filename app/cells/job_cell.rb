class JobCell < Cell::Rails
  cache :recent, :expires_in => 1.day

  def recent
    @jobs = Job.published.order("created_at desc").limit(5)
    render
  end

end
