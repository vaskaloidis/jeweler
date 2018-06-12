require 'test_helper'

class InvoicesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @project = create :project
    @sprint = @project.sprints.first
    @estimate = false
    @invoice = Invoice.new(sprint: @sprint,
                           estimate: @estimate,
                           display_send_btn: true,
                           display_pay_btn: true,
                           display_print_btn: true)
    sign_in @project.owner
  end

  test "should generate invoice" do
    get generate_invoice_url(@sprint, 'false'), xhr: true
    assert_response :success
  end

  test "should generate estimate" do
    get generate_invoice_url(@sprint, 'true'), xhr: true
    assert_response :success
  end

  test "should review customer invoice" do
    skip 'not finished yet'
    post review_customer_invoice_url, params: {invoice: {}}, xhr: true
    assert_response :success
  end

  test "should print invoice" do
    skip 'feature not finished yet'
    post print_invoice_url, params: {invoice: {}}, xhr: true
    assert_response :success
  end

  test "should send invoice" do
    skip 'not finished yet'
    post send_invoice_url, params: {invoice: {}}, xhr: true
    assert_response :success
  end

end
