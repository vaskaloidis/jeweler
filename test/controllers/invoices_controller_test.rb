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

  test 'review invoice' do
    customer = create(:user)
    @project.add_customer(customer)
    invoice_params = { sprint_id: @project.current_sprint.id, estimate: 'false', invoice_note: '(Optional) Invoice Note', user: customer.id }
    service = mock('ServiceObject')
    service.stubs(:result).returns(Invoice.new(invoice_params))
    service.stubs(:errors).returns([])
    ReviewInvoice.stubs(:call).returns(service)
    post review_customer_invoice_url, params: {invoice:  invoice_params }, xhr: true
    assert_response :success
  end

  test 'send invoice' do
    customer = create(:user)
    @project.add_customer(customer)
    invoice_params = { sprint_id: @project.current_sprint.id, estimate: 'false', invoice_note: '(Optional) Invoice Note', user: customer.id }
    post send_invoice_url, params: {invoice:  invoice_params }, xhr: true
    assert_response :success
  end

  test 'print invoice' do
    customer = create(:user)
    @project.add_customer(customer)
    invoice_params = { sprint_id: @project.current_sprint.id, estimate: 'false', invoice_note: '(Optional) Invoice Note', user: customer.id }
    post print_invoice_url, params: {invoice:  invoice_params }, xhr: true
    assert_response :success
  end

end
