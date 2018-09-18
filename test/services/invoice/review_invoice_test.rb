require 'test_helper'

class ReviewInvoiceTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @non_customer = 'non_customer_email@gmail.com'
    @customer = create(:user)
    @owner = create(:owner)
    @project = create(:project, :seed_tasks_notes, owner: owner)
    @project.add_customer(@customer)
  end

  test 'estimate for non_customer invite' do
    sign_in @owner
    @sprint = @project.sprints.second
    invoice = { estimate: 'true', customer_email: @non_customer, invoice_note: 'invoice-note-text', request_amount: 2000}
    service = ReviewInvoice.call(invoice)
    result = service.result
    assert result
    assert service.errors.full_messages.empty?
  end

  test 'estimate for existing customer' do
    sign_in @owner
    invoice = { estimate: 'true', user: @customer, invoice_note: 'invoice-note-text', request_amount: 1300}
    service = ReviewInvoice.call(invoice)
    expectation = Invoice.new(user: @customer, estimate: true, invoice_note: 'invoice-note-text', request_amount: 1300)
    result = service.result
    assert_equal expectation.user.id, result.user.id
    assert_equal expectation.estimate, result.estimate
    assert_equal expectation.invoice_note, result.invoice_note
    assert_equal expectation.request_amount, result.request_amount
    assert service.errors.full_messages.empty?
  end

  test 'returns error for non-number payment-request-amount' do
    sign_in @owner
    invoice = { estimate: 'true', user: @customer, invoice_note: 'invoice-note-text', request_amount: 'non-number'}
    service = ReviewInvoice.call(invoice)
    result = service.result
    assert service.errors.full_messages.count.positive?
  end

end