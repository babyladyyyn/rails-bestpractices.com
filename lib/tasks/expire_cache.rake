namespace :expire_cache do
  task :tag_section => :environment do
    ApplicationController.new.expire_fragment("tag_section")
  end
end
