require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Firefly
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Eastern Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.assets.paths << Rails.root.join('app', 'assets', 'videos')

    config.to_prepare do
      Devise::SessionsController.layout "clean"
      #Devise::RegistrationsController.layout proc{ |controller| user_signed_in? ? "backend" : "application" }
      Devise::RegistrationsController.layout "clean"
      #Devise::ConfirmationsController.layout "frontend"
      #Devise::UnlocksController.layout "frontend"
      Devise::PasswordsController.layout "clean"
    end

    config.middleware.insert_before 0, "Rack::Cors" do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options]
      end
    end

    ActionMailer::Base.smtp_settings = {
      :port           => 587,
      :address        => 'smtp.mailgun.org',
      :user_name      => ENV['SMTP_USERNAME'],
      :password       => ENV['SMTP_PASSWORD'],
      :domain         => ENV['SMTP_DOMAIN'],
      :authentication => :plain,
    }
    ActionMailer::Base.delivery_method = :smtp

  end
end
