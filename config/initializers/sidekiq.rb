Sidekiq.configure_server do |config|
  config.redis = { url: Rails.application.secrets.redis_url }
end

Sidekiq.configure_server do |config|
  config.redis = { url: Rails.application.secrets.redis_url }
end
