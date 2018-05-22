require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

unless Rails.env.production?
  Dotenv::Railtie.load
end

require 'carrierwave'
require 'carrierwave/orm/activerecord'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.

module JewlerCRM
  class Application < Rails::Application
    # TODO: We load these already in application_controller before_action. Remove one of them
    # config.autoload_paths += %W(#{config.root}/lib)
    # config.autoload_paths += Dir["#{config.root}/lib/**/"]

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    # TODO: Update this with Rails version once we update to 5.2

    config.generators do |g|
      # g.factory_bot dir: 'test/factories'
      # g.test_framework :rspec, :fixture => true
      g.test_framework  :test_unit, fixture: true
    end


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
