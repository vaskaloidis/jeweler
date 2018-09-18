# The controller for building and configuring Sprint Invoices. This controller has
#  actions to generate a Sprint's Invoice, choose a customer, print or send.
class InvoicesController < ApplicationController
  before_action :set_sprint, only: %i[generate select_customer]
  respond_to :js, except: %i[print]

  def generate
    @invoice = Invoice.new(sprint: @sprint,
                           estimate: @estimate,
                           customer: false,
                           customer_email: false,
                           display_payments: false)
  end

  def select_customer
    @goal = params[:goal]
    @invoice = Invoice.new(sprint: @sprint,
                           estimate: @estimate,
                           display_pay_btn: true,
                           goal: @goal)
  end

  def review
    service = ReviewInvoice.call(invoice_params)
    @invoice = service.result
    @errors.concat(service.errors)
  end

  def send_invoice; end

  def print
    @invoice = Invoice.new(invoice_params)
    render partial: 'invoices/generate_printable_invoice',
           locals: {sprint_id: @invoice.sprint.id,
                    estimate: @invoice.estimate,
                    display_send_btn: false,
                    display_pay_btn: false,
                    display_print_btn: false},
           layout: 'print'
  end

  private

  def set_sprint
    @sprint = Sprint.find(params[:sprint_id])
    @estimate = params[:estimate].to_b
    raise ArgumentError, 'InvoicesController: sprint_id was not defined in the request' if @sprint.nil?
  end

  def invoice_params
    params.require(:invoice).permit(:sprint, :estimate, :display_send_btm, :display_pay_btn, :display_print_btn, :request_amount, :invoice_note, :display_payments, :customer_email, :user, :user_id, :sprint, :sprint_id)
  end
  # params.require(:sprint).
  #   permit(:sprint, :payment_due_date, :open, :payment_due, :description)

end
