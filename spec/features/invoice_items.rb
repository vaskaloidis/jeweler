require "rails_helper"

RSpec.feature "Invoice Item", :type => :feature do
  scenario "Create a new Invoice Item" do
    visit root_path

    click_button "Create Task"

    fill_in "Name", :with => "Task Description"
    click_button "Create Task"

    expect(page).to have_text("Widget was successfully created.")
  end
end