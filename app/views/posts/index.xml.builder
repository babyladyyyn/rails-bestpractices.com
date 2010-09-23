xml.instruct!
xml.rss(:version => '2.0') do
  xml.channel do
    xml.title "rails-bestpractices.com"
    xml.link "http://rails-bestpractices.com"
    xml.description 'Learn the best practices of rails app and share your rails best practices'
    xml.language 'en-us'

    @posts.each do |post|
      descriptions = ["#{post.description}    #{link_to 'see more', post_url(post)}"]
      descriptions << "<div><p><b>Recommendation:</b><center><a href='http://www.rubyslide.com'>RubySlide</a> gathers all the latest Ruby slides and presentations in one convenient place!</center><p></div>"
      if post.related_posts.present?
        descriptions << "<div><p><b>Related Posts</b></p><ul>"
        post.related_posts.each do |p|
          descriptions << "<li>#{link_to p.title, post_url(p)}</li>"
        end
        descriptions << "</ul></div>"
      end
      xml.item do
        xml.title post.title
        xml.description descriptions.join('')
        xml.author post.user.login
        xml.pubDate post.created_at
        xml.link post_url(post)
        xml.guid post_url(post)
      end
    end
  end
end
