require 'test_helper'

class InvoiceItemsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in create(:owner)
    @project = create(:project)
    @invoice = @project.invoices.first
    @invoice_item = @invoice.invoice_items.first
  end

  test "should get new" do
    get new_invoice_item_url, xhr: true

    assert_response :success
    assert_equal "text/javascript", @response.content_type
  end

  test "should create invoice_item" do
    assert_difference('InvoiceItem.count') do
      post invoice_items_url, params: { invoice_item: attributes_for(:invoice_item) }, xhr:true
    end
    assert_response :success
    assert_equal "text/javascript", @response.content_type
  end

  test "should get edit" do
    get edit_invoice_item_url(@invoice_item), xhr: true
    assert_response :success
    assert_equal "text/javascript", @response.content_type
  end

  test "should update invoice_item" do
    patch invoice_item_url(@invoice_item), params: attributes_for(:invoice_item_update), xhr: true
    assert_response :success
    assert_equal "text/javascript", @response.content_type
  end

  test "should destroy invoice_item" do
    assert_difference('InvoiceItem.count', -1) do
      delete invoice_item_url(@invoice_item), xhr: true
    end

    assert_response :success
    assert_equal "text/javascript", @response.content_type
  end
end
