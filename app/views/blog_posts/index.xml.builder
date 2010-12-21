xml.instruct!
xml.rss(:version => '2.0') do
  xml.channel do
    xml.title "Team Blog of Rails Best Practices"
    xml.link "http://rails-bestpractices.com/blog_posts"
    xml.description 'Team blog of rails-bestpractices.com and rails_best_practices gem'
    xml.language 'en-us'

    @blog_posts.each do |blog_post|
      xml.item do
        xml.title blog_post.title
        xml.description blog_post.body
        xml.author blog_post.user.login
        xml.pubDate blog_post.created_at
        xml.link blog_post_url(blog_post)
        xml.guid blog_post_url(blog_post)
      end
    end
  end
end
