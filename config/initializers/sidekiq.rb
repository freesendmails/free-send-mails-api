require 'sidekiq'
require 'sidekiq/web'

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == [Rails.application.secrets.secret_key_access, Rails.application.secrets.secret_key_password]
end

Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://redis:6379/0' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://redis:6379/0' }
end
