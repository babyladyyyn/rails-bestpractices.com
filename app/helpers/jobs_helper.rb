module JobsHelper
  def job_partner_links
    raw JobPartner.all.map { |partner| link_to(partner.name, "http://#{partner.name}") }.join(", ")
  end
end
