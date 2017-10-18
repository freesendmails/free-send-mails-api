source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.1'
gem 'puma', '~> 3.0'
gem 'rack-cors'
gem 'sidekiq'
gem 'redis'
gem 'firebase'
gem 'validation_contract'
gem 'base58'

group :development, :test do
  gem 'byebug'
  gem 'rspec-rails'
  gem 'factory_girl'
  gem 'ffaker'
end

group :test do
  gem 'webmock'
  gem 'vcr'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
