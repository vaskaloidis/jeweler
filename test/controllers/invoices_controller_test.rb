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
    get generate_invoice, xhr: true
    assert_response :success
  end

  test "should select invoice customer" do
    get select_invoice_customer, xhr: true
    assert_response :success
  end

  test "should review customer invoice" do
    post review_customer_invoice, params: {invoice: {}}, xhr: true
    assert_response :success
  end

  test "should print invoice" do
    post print_invoice, params: {invoice: {}}, xhr: true
    assert_response :success
  end

  test "should send invoice" do
    post send_invoice, params: {invoice: {}}, xhr: true
    assert_response :success
  end

end
