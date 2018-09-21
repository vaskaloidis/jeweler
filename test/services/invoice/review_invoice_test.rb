require 'test_helper'

class ReviewInvoiceTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @non_customer = 'non_customer_email@gmail.com'
    @customer = create(:user)
    @owner = create(:owner)
    @project = create(:project, :seed_tasks_notes, owner: @owner)
    @project.add_customer(@customer)
    @sprint = @project.get_sprint(2)
  end

  test 'estimate for non_customer invite' do
    sign_in @owner
    invoice = { sprint_id: @sprint.id, estimate: true, customer_email: @non_customer, invoice_note: 'invoice-note-text', request_amount: 2000}
    service = ReviewInvoice.call(invoice)
    result = service.result
    assert_equal invoice[:sprint_id], result.sprint.id
    assert_equal invoice[:customer_email], result.customer_email
    assert_nil result.user
    assert_equal invoice[:estimate], result.estimate
    assert_equal invoice[:invoice_note], result.invoice_note
    # assert_equal invoice[:request_amount], result.request_amount TODOO: Fix this
    assert service.errors.empty?
  end

  test 'estimate for existing customer' do
    sign_in @owner
    params = { sprint_id: @sprint.id, estimate: true, user_id: @customer.id, invoice_note: 'invoice-note-text', request_amount: 1300}
    service = ReviewInvoice.call(params)
    invoice = Invoice.new(sprint: @sprint, user: @customer, estimate: true, invoice_note: 'invoice-note-text', request_amount: 1300)
    result = service.result
    assert_equal invoice.sprint.id, result.sprint.id
    assert_equal invoice.user.id, result.user.id
    assert_nil result.customer_email
    assert_equal invoice.estimate, result.estimate
    assert_equal invoice.invoice_note, result.invoice_note
    assert_equal invoice.request_amount, result.request_amount
    assert service.errors.empty?
  end

  test 'invoice for existing customer' do
    sign_in @owner
    params = { sprint_id: @sprint.id, estimate: false, user_id: @customer.id, invoice_note: 'invoice-note-text', request_amount: 1300}
    service = ReviewInvoice.call(params)
    invoice = Invoice.new(sprint: @sprint, user: @customer, estimate: false, invoice_note: 'invoice-note-text', request_amount: 1300)
    result = service.result
    assert_equal invoice.sprint.id, result.sprint.id
    assert_equal invoice.user.id, result.user.id
    assert_nil result.customer_email
    assert_equal invoice.estimate, result.estimate
    assert_equal invoice.invoice_note, result.invoice_note
    assert_equal invoice.request_amount, result.request_amount
    assert service.errors.empty?
  end

  test 'returns error for non-number payment-request-amount' do
    sign_in @owner
    invoice = { sprint_id: @sprint.id, estimate: true, user: @customer.id, invoice_note: 'invoice-note-text', request_amount: 'non-number' }
    service = ReviewInvoice.call(invoice)
    result = service.result
    assert result
    refute service.errors.empty?
  end

end