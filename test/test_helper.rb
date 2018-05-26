ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'faker'
require 'minitest/reporters'
require 'capybara/email'

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods
  Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new({ color: true })]
  # Minitest::Reporters.use!(Minitest::Reporters::ProgressReporter.new,ENV,Minitest.backtrace_filter)

  include Warden::Test::Helpers
end