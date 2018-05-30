ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'faker'
require 'minitest/reporters'
Minitest::Reporters.use! [Minitest::Reporters::ProgressReporter]
require 'capybara/email'
require 'coveralls'
Coveralls.wear!

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods
  Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new({color: true})]
  # Minitest::Reporters.use!(Minitest::Reporters::ProgressReporter.new,ENV,Minitest.backtrace_filter)

  # include Warden::Test::Helpers

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end
end