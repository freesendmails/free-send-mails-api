source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.1'
gem 'puma', '~> 4.3'
gem 'rack-cors'
gem 'sidekiq'
gem 'redis'
gem 'firebase'
gem 'validation_contract', '~> 0.1.10'
gem 'base58'
gem 'rubocop', '~> 0.51.0', require: false

group :development, :test do
  gem 'byebug'
  gem 'factory_bot'
  gem 'ffaker'
  gem 'rspec-rails'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
