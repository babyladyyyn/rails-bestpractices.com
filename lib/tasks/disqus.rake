namespace :disqus do
  task :dump_posts => :environment do
    File.open("post_comments.xml", "w+") do |file|
      dump_channel file do
        Post.published.all.each do |post|
          dump_item post, file, path: "/posts/#{post.to_param}" do
            dump_comments post, file
          end
        end
      end
    end
  end

  task :dump_blog_posts => :environment do
    File.open("blog_post_comments.xml", "w+") do |file|
      dump_channel file do
        BlogPost.all.each do |post|
          dump_item post, file, path: "/blog/posts/#{post.to_param}" do
            dump_comments post, file
          end
        end
      end
    end
  end

  def dump_comments(item, output)
    item.comments.all.each do |comment|
      output.write "<wp:comment>
                      <wp:comment_id>#{comment.id}</wp:comment_id>
                      <wp:comment_author>#{comment.user ? comment.user.login : comment.username}</wp:comment_author>
                      <wp:comment_author_email>#{comment.user ? comment.user.email : comment.email}</wp:comment_author_email>
                      <wp:comment_author_url>#{comment.user ? comment.user.url : ''}</wp:comment_author_url>
                      <wp:comment_author_IP></wp:comment_author_IP>
                      <wp:comment_date_gmt>#{comment.created_at.to_s(:db)}</wp:comment_date_gmt>
                      <wp:comment_content><![CDATA[#{comment.body}]]></wp:comment_content>
                      <wp:comment_approved>1</wp:comment_approved>
                      <wp:comment_parent>0</wp:comment_parent>
                    </wp:comment>"
    end
  end

  def dump_item(item, output, options={})
    output.write "<item>
                    <title>#{item.title}</title>
                    <link>http://rails-bestpractices.com#{options[:path]}</link>
                    <dsq:thread_identifier>#{item.to_param}</dsq:thread_identifier>
                    <wp:post_date_gmt>#{item.created_at.to_s(:db)}</wp:post_date_gmt>
                    <wp:comment_status>open</wp:comment_status>"
    yield
    output.write "</item>"
  end

  def dump_channel(output)
    output.write '<?xml version="1.0" encoding="UTF-8"?>
                  <rss version="2.0"
                    xmlns:content="http://purl.org/rss/1.0/modules/content/"
                    xmlns:dsq="http://www.disqus.com/"
                    xmlns:dc="http://purl.org/dc/elements/1.1/"
                    xmlns:wp="http://wordpress.org/export/1.0/"
                  >
                    <channel>'
    yield
    output.write '  </channel>
                  </rss>'
  end
end
