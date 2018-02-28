require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)
Dotenv::Railtie.load


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module JewlerCRM
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.generators do |g|
      g.factory_bot dir: 'spec/factories'
      g.test_framework  :rspec, :fixture => true

      config.action_mailer.perform_deliveries = true # Set it to false to disable the email in dev mode
      config.action_mailer.raise_delivery_errors = true
      config.action_mailer.delivery_method = :smtp
      config.action_mailer.default_url_options = { :host => "localhost:3000" }


      ActionMailer::Base.smtp_settings = {
          :address        => "smtp.gmail.com",
          :port           => 587,
          :authentication => :plain,
          :user_name      => ENV['GMAIL_EMAIL'],
          :password       => ENV['GMAIL_PASSWORD']
      }

    end

  end
end
