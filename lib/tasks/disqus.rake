namespace :disqus do
  task :migrate_posts => :environment do
    require 'rest_client'

    disqus_url = 'http://disqus.com/api/3.0'

    secret_key = 'AAOKf17nUhL6UwWuYpbsEpsIEMdplYR7p80mPpA4yAFFtMD08oIHpl2b3n9EVwmE'
    current_blog_base_url = 'http://rails-bestpractices.com'

    resource = RestClient::Resource.new disqus_url

    forum_id = 'railsbestpractices'

    Comment.for_post.each do |comment|
      post = comment.commentable
      post_url = "#{current_blog_base_url}/posts/#{post.to_param}"
      title = "Rails Best Practices | #{post.title}"

      begin
        thread_id = nil
        JSON.parse(resource['/threads/list.json?api_secret='+secret_key+'&forum='+forum_id].get)["response"].each do |thread|
          thread_id = thread["id"] if thread["link"] == post_url
        end

        unless thread_id
          request_body = {:forum => forum_id, :title => title, :url => post_url}
          thread = JSON.parse(resource['/threads/create.json?api_secret='+secret_key].post(request_body))["response"]
          thread_id = thread["id"]
        end

        request_body = {:thread => thread_id, :message => comment.body.strip, :date => comment.created_at.to_i}
        if comment.user
          request_body.merge!(:author_email => comment.user.email)
          request_body.merge!(:author_name => comment.user.login)
          request_body.merge!(:author_url => comment.user.url)
        else
          request_body.merge!(:author_name => comment.username)
        end
        if JSON.parse(resource['/posts/create.json?api_secret='+secret_key].post(request_body))["code"] == 0
          puts "Success: #{comment.id} on #{post.title}"
        else
          puts "FAIL: #{comment.id} on #{post.title}"
        end
      rescue
        puts "Rescue: #{post_url} {$!}"
      end
    end
  end
end
