unless ENV['JEWELER_RAKE_TASK'].nil?
  puts 'Test-Helper Loaded from Rake Task'
end

require 'simplecov'
SimpleCov.start 'rails'
# Rails.application.eager_load!

# SimpleCov.root(root_path)

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/around/unit'
require 'faker'
#TODO: Faker has to get removed from here once we find out where its being used
# require 'capybara/email'

formatters = []
formatters << SimpleCov::Formatter::HTMLFormatter
formatters << SimpleCov::Formatter::Console
SimpleCov.formatters = SimpleCov::Formatter::MultiFormatter.new(formatters)

unless try(ENV['LOCAL_DEVELOPMENT'])
  require 'coveralls'
  Coveralls.wear!
end

require 'minitest/reporters'
# https://github.com/kern/minitest-reporters/issues/230
Minitest.load_plugins
Minitest.extensions.delete('rails')
Minitest.extensions.unshift('rails')
reporters = []
reporters << Minitest::Reporters::SpecReporter.new
# reporters << Minitest::Reporters::JUnitReporter.new
# reporters << Minitest::Reporters::ProgressReporter.new(color: true)
# reporters << Minitest::Reporters::DefaultReporter.new({color: true})
# reporters << Minitest::Reporters::RubyMineReporter
Minitest::Reporters.use! reporters

require 'webmock/minitest'

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  # Mocha
  # include Minitest::RSpecMocks
  # RSpec::Mocks.configuration.syntax = :expect

  def setup
    DatabaseCleaner.start
    if Bullet.enable?
      Bullet.start_request
    end
  end

  def teardown
    if Bullet.enable?
      Bullet.perform_out_of_channel_notifications if Bullet.notification?
      Bullet.end_request
    end
    DatabaseCleaner.clean
  end

  def github_app_env(client_id, client_secret, &block)
    ClimateControl.modify({GITHUB_CLIENT_ID: client_id, GITHUB_CLIENT_SECRET: client_secret}, &block)
  end

  def github_oauth_env(client_id, &block)
    ClimateControl.modify( GITHUB_CLIENT_SECRET: client_secret}, &block)
  end
end

require 'mocha/minitest'
