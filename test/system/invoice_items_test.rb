require "application_system_test_case"

class InvoiceItemsTest < ApplicationSystemTestCase
  setup do
    @invoice_item = invoice_items(:one)
  end

  test "visiting the index" do
    visit invoice_items_url
    assert_selector "h1", text: "Invoice Items"
  end

  test "creating a Invoice item" do
    visit invoice_items_url
    click_on "New Invoice Item"

    click_on "Create Invoice item"

    assert_text "Invoice item was successfully created"
    click_on "Back"
  end

  test "updating a Invoice item" do
    visit invoice_items_url
    click_on "Edit", match: :first

    click_on "Update Invoice item"

    assert_text "Invoice item was successfully updated"
    click_on "Back"
  end

  test "destroying a Invoice item" do
    visit invoice_items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Invoice item was successfully destroyed"
  end
end
