namespace :sitemap do
  task :refresh do
    on roles(:db) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, "exec rake -s sitemap:refresh:no_ping"
        end
      end
    end
    after :published, "sitemap:refresh"
  end
end
