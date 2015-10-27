require 'sidekiq'

if Rails.env.development?
  Sidekiq.configure_client do |config|
    config.redis = { :size => 1 }
  end

  Sidekiq.configure_server do |config|
    config.redis = { :size => 2 }
  end
end

if Rails.env.production?
  Sidekiq.configure_client do |config|
    config.redis = { :url => ENV["REDIS_URL_EXT"], :size => 1 }
  end

  Sidekiq.configure_server do |config|
    config.redis = { :url => ENV["REDIS_URL_EXT"], :size => 2 }
  end
end