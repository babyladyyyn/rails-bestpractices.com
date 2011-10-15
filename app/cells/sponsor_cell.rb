class SponsorCell < Cell::Rails
  cache :active, :expires_in => 1.day

  def active
    @sponsors = Sponsor.active
    render
  end

end
