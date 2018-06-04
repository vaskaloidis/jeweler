require 'simplecov'
SimpleCov.start 'rails' unless ENV['NO_COVERAGE']
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'faker'
require 'minitest/reporters'
# Minitest::Reporters.use! [Minitest::Reporters::ProgressReporter]
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new({color: true})]
require 'capybara/email'
require 'coveralls'
Coveralls.wear!

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  # Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new({color: true})]
  # Minitest::Reporters.use!(Minitest::Reporters::ProgressReporter.new,ENV,Minitest.backtrace_filter)

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end
end