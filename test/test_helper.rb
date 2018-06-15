require 'simplecov'
SimpleCov.start 'rails'
# SimpleCov::Formatter::Console]
SimpleCov.formatters = SimpleCov::Formatter::MultiFormatter.new([SimpleCov::Formatter::HTMLFormatter])
# SimpleCov.root(root_path)
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'faker'
require 'minitest/reporters'
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new({color: true})]
# require 'capybara/email'
require 'coveralls'
Coveralls.wear!

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end
end