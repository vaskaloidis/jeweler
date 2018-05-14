require "application_system_test_case"

class MainsTest < ApplicationSystemTestCase
  test "visiting the unauthenticated home" do
    visit root_path

    assert_selector "h2", text: "CUSTOMER RELATIONSHIP MANAGEMENT"
  end
end
