%w(Full-time Part-time Contract Permanent Temporary Internship).each do |name|
  JobType.create(:name => name)
end
