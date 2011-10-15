class JobPartnerCell < Cell::Rails
  cache :hint, :expires_in => 1.day

  def hint
    @job_partners = JobPartner.all
    render
  end

end
