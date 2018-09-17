require "test_helper"
require "capybara/poltergeist"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include Devise::Test::IntegrationHelpers
  include Warden::Test::Helpers
  Warden.test_mode!

  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
  # driven_by :poltergeist
end