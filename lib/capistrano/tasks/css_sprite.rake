namespace :css_sprite do
  desc "build css sprite"
  task :build do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, "exec rake css_sprite:build"
        end
      end
    end
  end
  before "deploy:compile_assets", "css_sprite:build"
end
