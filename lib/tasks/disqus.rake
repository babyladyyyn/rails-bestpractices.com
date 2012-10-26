namespace :disqus do
  task :dump_posts => :environment do
    File.open("comments.xml", "w+") do |file|
      file.write '<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0"
  xmlns:content="http://purl.org/rss/1.0/modules/content/"
  xmlns:dsq="http://www.disqus.com/"
  xmlns:dc="http://purl.org/dc/elements/1.1/"
  xmlns:wp="http://wordpress.org/export/1.0/"
>
  <channel>'
      Post.published.all.each do |post|
        file.write "<item>
      <title>#{post.title}</title>
      <link>http://rails-bestpractices.com/posts/#{post.to_param}</link>
      <dsq:thread_identifier>#{post.to_param}</dsq:thread_identifier>
      <wp:post_date_gmt>#{post.created_at.to_s(:db)}</wp:post_date_gmt>
      <wp:comment_status>open</wp:comment_status>"
        post.comments.all.each do |comment|
          file.write "<wp:comment>
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
        file.write "</item>"
      end
      file.write '</channel>
</rss>'
    end
  end
end
