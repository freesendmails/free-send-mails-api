require 'sidekiq'
require 'sidekiq/web'

Sidekiq.configure_server do |config|
  config.redis = { url: "#{ENV['REDISTOGO_URL']}:6379/5"}
end

Sidekiq.configure_client do |config|
  config.redis = { url: "#{ENV['REDISTOGO_URL']}:6379/5"}
end
