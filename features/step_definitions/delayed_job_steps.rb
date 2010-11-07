Given /^all delayed jobs have finished$/ do
  Delayed::Job.all.each do |job|
    job.payload_object.perform
    job.destroy
  end
end
