guard 'annotate', :run_at_start => false do
  watch( 'db/schema.rb' )
end

guard 'bundler' do
  watch('Gemfile')
end

guard 'livereload' do
  watch(%r{app/.+\.(erb|haml)})
  watch(%r{app/helpers/.+\.rb})
  watch(%r{app/stylesheets/.+.scss}) { |m| m[1] }
  watch(%r{public/javascripts/.+.js}) { |m| m[1] }
  #watch(%r{(public/|app/assets).+\.(css|js|html)})
  #watch(%r{(app/assets/.+\.css)\.s[ac]ss}) { |m| m[1] }
  #watch(%r{(app/assets/.+\.js)\.coffee}) { |m| m[1] }
  watch(%r{config/locales/.+\.yml})
end

guard 'rails' do
  watch('Gemfile.lock')
  watch(%r{^(config|lib)/.*})
end


guard 'spork', :cucumber_env => { 'RAILS_ENV' => 'test' }, :rspec_env => { 'RAILS_ENV' => 'test' } do
  watch('config/application.rb')
  watch('config/environment.rb')
  watch(%r{^config/environments/.+\.rb$})
  watch(%r{^config/initializers/.+\.rb$})
  watch('Gemfile')
  watch('Gemfile.lock')
  watch('spec/spec_helper.rb')
  watch('test/test_helper.rb')
end
