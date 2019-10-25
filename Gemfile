source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'base58'
gem 'firebase'
gem 'nokogiri', '~> 1.10.4'
gem 'puma', '~> 3.0'
gem 'rack-cors'
gem 'rails', '~> 5.0.7.2'
gem 'redis'
gem 'rubocop', '~> 0.51.0', require: false
gem 'sidekiq'
gem 'validation_contract', '~> 0.1.10'

group :development, :test do
  gem 'byebug'
  gem 'factory_bot'
  gem 'ffaker'
  gem 'rspec-rails'
end

group :test do
  gem 'vcr'
  gem 'webmock'
end

group :development do
  gem 'ffi', '~> 1.9.24'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
