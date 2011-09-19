namespace :job_share do
  task :rubyonjobs => :environment do
    doc = Nokogiri::XML(open('http://www.rubyonjobs.com/partner?id=rails-bestpractices'))
    doc.xpath('//item').each do |element|
      if Job.where(:source => "rubyonjobs.com", :external_id => element.xpath("id").text.to_i).blank?
        job = Job.new(:source => "rubyonjobs.com")
        job.external_id = element.xpath("id").text
        job.company = element.xpath("company").text
        job.company_url = element.xpath("urlcompany").text
        job.apply_email = element.xpath("apply").text
        job.title = element.xpath("title").text
        job.created_at = element.xpath("pubDate").text
        job.country = element.xpath("country").text
        job.city = element.xpath("city").text
        # element.xpath("zipcode").text
        job.salary = element.xpath("salary").text
        job.description = element.xpath("description").text
        job.save
      end
    end
  end
end
