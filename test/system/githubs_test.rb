require "application_system_test_case"

class GithubsTest < ApplicationSystemTestCase
  setup do
    @github = githubs(:one)
  end

  test "visiting the index" do
    visit githubs_url
    assert_selector "h1", text: "Githubs"
  end

  test "creating a Github" do
    visit githubs_url
    click_on "New Github"

    click_on "Create Github"

    assert_text "Github was successfully created"
    click_on "Back"
  end

  test "updating a Github" do
    visit githubs_url
    click_on "Edit", match: :first

    click_on "Update Github"

    assert_text "Github was successfully updated"
    click_on "Back"
  end

  test "destroying a Github" do
    visit githubs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Github was successfully destroyed"
  end
end
