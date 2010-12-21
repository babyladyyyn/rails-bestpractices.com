# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://rails-bestpractices.com"

SitemapGenerator::Sitemap.add_links do |sitemap|
  sitemap.add root_path, :priority => 0.7, :changefreq => 'daily'
  Post.published.each do |p|
    sitemap.add post_path(p), :lastmod => p.updated_at, :priority => 1.0, :changefreq => 'daily'
  end
  Implementation.all.each do |i|
    sitemap.add post_implementation_path(i.post), :lastmod => i.updated_at, :priority => 1.0, :changefreq => 'daily'
  end
  Page.all.each do |p|
    sitemap.add page_path(p.name), :lastmod => p.updated_at, :priority => 0.5, :changefreq => 'monthly'
  end
  Question.all.each do |q|
    sitemap.add question_path(q), :lastmod => q.updated_at, :priority => 1.0, :changefreq => 'daily'
  end
end
