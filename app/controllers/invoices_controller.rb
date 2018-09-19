# The controller for building and configuring Sprint Invoices. This controller has
#  actions to generate a Sprint's Invoice, choose a customer, print or send.
class InvoicesController < ApplicationController
  before_action :set_sprint, only: %i[generate select_customer]
  before_action :set_invoice, only: %i[send_invoice print]
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
    @errors = service.errors
  end

  def send_invoice; end

  def print
    render partial: 'invoices/generate_printable', locals: { invoice: @invoice }, layout: 'print'
  end

  private

  def set_invoice
    @invoice = Invoice.new(invoice_params)
    @invoice.sprint = Sprint.find(invoice_params[:sprint_id]) unless invoice_params[:sprint_id].nil?
    @invoice.user = User.find(invoice_params[:user_id]) unless invoice_params[:user_id].nil?
  end

  def set_sprint
    @sprint = Sprint.find(params[:sprint_id])
    @estimate = params[:estimate].to_b
  end

  def invoice_params
    params.require(:invoice).permit(:sprint, :estimate, :display_send_btm, :display_pay_btn, :display_print_btn, :request_amount, :invoice_note, :display_payments, :customer_email, :user, :user_id, :sprint, :sprint_id, :invitation)
  end
end
