xml.instruct!
xml.rss(:version => '2.0') do
  xml.channel do
    xml.title "jobs on rails-bestpractices.com"
    xml.link "http://rails-bestpractices.com/jobs"
    xml.description 'Post jobs on rails-bestpractices to find good ruby and rails developers'
    xml.language 'en-us'

    @jobs.each do |job|
      xml.item do
        xml.title "#{job.title} (#{job.location})"
        xml.description job.description
        xml.author job.cached_user.try(:login)
        xml.pubDate job.created_at
        xml.link job_url(job)
        xml.guid job_url(job)
      end
    end
  end
end
