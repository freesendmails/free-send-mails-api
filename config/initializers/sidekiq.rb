require 'sidekiq'
require 'sidekiq/web'

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == [Rails.application.secrets.secret_key_access, Rails.application.secrets.secret_key_password.to_s]
end

Sidekiq.configure_server do |config|
  config.redis = { url: Rails.application.secrets.secret_redis_url}
end

Sidekiq.configure_client do |config|
  config.redis = { url: Rails.application.secrets.secret_redis_url}
end
