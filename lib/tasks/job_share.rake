require 'open-uri'

namespace :job_share do
  task :rubyonjobs => :environment do
    JOB_TYPES = {
      "1" => "Fulltime",
      "2" => "Contract",
      "3" => "Remote",
      "4" => "Freelance",
      "5" => "All"
    }
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
        job_types = element.xpath("jobtype").children.map { |ele| JOB_TYPES[ele.text] }
        if job_types.delete("All")
          job_types = JOB_TYPES.values - ["All"]
        end
        job_types.each do |job_type|
          job.job_types << JobType.find_or_create_by_name(job_type)
        end
        job.save
      end
    end
  end
end
