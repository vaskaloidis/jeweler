require 'test_helper'

class InvoicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sprint = create(:sprint)
    @estimate = false
    @invoice = Invoice.create(sprint: @sprint,
                              estimate: @estimate,
                              display_send_btn: true,
                              display_pay_btn: true,
                              display_print_btn: true)
  end

  test "should get generate invoice" do
    get generate_invoice, xhr: true
    assert_response :success
  end

  test "should get select invoice customer" do
    get select_invoice_customer, xhr: true
    assert_response :success
  end

  test "should review customer invoice" do
    post review_customer_invoice, params: { invoice: {  } }, xhr: true
    assert_response :success
  end

  test "should print invoice" do
      post print_invoice, params: { invoice: {  } }, xhr: true
      assert_response :success
  end

  test "should send invoice" do
    post send_invoice, params: { invoice: {  } }, xhr: true
    assert_response :success
  end

end
