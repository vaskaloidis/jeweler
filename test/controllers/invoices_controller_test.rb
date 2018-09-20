require 'test_helper'

class InvoicesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @project = create(:project, :seed_tasks_notes, :seed_project_users)
    @sprint = @project.sprints.first
    @estimate = false
    @invoice = Invoice.new(sprint: @sprint,
                           estimate: @estimate,
                           display_send_btn: true,
                           display_pay_btn: true,
                           display_print_btn: true)
    sign_in @project.owner
  end

  test 'should generate invoice' do
    get generate_invoice_url(@sprint, 'false'), xhr: true
    assert_response :success
  end

  test 'generate estimate' do
    get generate_invoice_url(@sprint, 'true'), xhr: true
    assert_response :success
  end

  test 'review estimate for project-customer' do
    customer = create(:user)
    @project.add_customer(customer)
    invoice_params = { estimate: 'true', sprint_id: @project.current_sprint.id, user_id: customer.id, customer_email: 'Customer Email', invoice_note: '(Optional) Invoice Note', request_amount: '(Optional) Request Amount' }
    post review_customer_invoice_url, params: { invoice: invoice_params }, xhr: true
    assert_response :success
  end

  test 'review invoice for non-user email' do
    customer = create(:user)
    @project.add_customer(customer)
    invoice_params = { estimate: 'false', sprint_id: @project.current_sprint.id, customer_email: 'somebodysemail@gmail.com', invoice_note: '(Optional) Invoice Note', request_amount: '(Optional) Request Amount' }
    post review_customer_invoice_url, params: { invoice: invoice_params }, xhr: true
    assert_response :success
  end

  test 'send estimate to non-user email' do
    customer = create(:user)
    @project.add_customer(customer)
    invoice_params = { estimate: 'true', sprint_id: @project.current_sprint.id, customer_email: 'somebody@gmail.com', invoice_note: '(Optional) Invoice Note', request_amount: '(Optional) Request Amount' }
    post send_invoice_url, params: {invoice:  invoice_params }, xhr: true
    assert_response :success
  end

  test 'send invoice to project-customer' do
    customer = create(:user)
    @project.add_customer(customer)
    invoice_params = { estimate: 'false', sprint_id: @project.current_sprint.id, user_id: customer.id, invoice_note: '(Optional) Invoice Note', request_amount: '(Optional) Request Amount' }
    post send_invoice_url, params: {invoice:  invoice_params }, xhr: true
    assert_response :success
  end

  test 'print invoice for customer' do
    customer = create(:user)
    @project.add_customer(customer)
    invoice_params = { estimate: 'false', sprint_id: @project.current_sprint.id, customer_email: '', user_id: customer.id, invoice_note: '(Optional) Invoice Note', request_amount: '(Optional) Request Amount' }
    post print_invoice_url, params: {invoice:  invoice_params }, xhr: true
    assert_response :success
  end

end
