require_relative 'boot'
require 'rails/all'
Bundler.require(*Rails.groups)

unless Rails.env.production?
  Dotenv::Railtie.load
end

require 'carrierwave'
require 'carrierwave/orm/activerecord'

module JewlerCRM
  class Application < Rails::Application
    config.load_defaults 5.1 # TODO: Update this with Rails version once we update to 5.2

    config.generators do |g|
      g.factory_bot dir: 'test/factories'
      # g.test_framework :rspec, :fixture => true
      g.test_framework  :test_unit, fixture: false
      g.stylesheets     false
      g.javascripts     false
      g.helper          false
    end

    config.reform.enable_active_model_builder_methods = true

    config.action_mailer.perform_deliveries = true # Set it to false to disable the email in dev mode
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.delivery_method = :smtp
    ActionMailer::Base.smtp_settings = {
        :address => "smtp.gmail.com",
        :port => 587,
        :authentication => :plain,
        :domain => 'gmail.com',
        :user_name => ENV['GMAIL_EMAIL'],
        :password => ENV['GMAIL_PASSWORD']
    }


  end
end
