class ReviewInvoice < Jeweler::Service

  def initialize(params)
    @params = params
  end

  # @return [Invoice] invoice
  def call
    parse_form
  end

  private

  attr_reader :params

  def parse_form
    invoice = Invoice.new
    invoice.sprint = Sprint.find(params[:sprint_id])
    invoice.estimate = params[:estimate]
    # binding.pry
    if params[:customer_email] == 'Customer Email' || params[:customer_email].empty?
      if params[:user].nil? or params[:user] == ''
        errors << 'A customer was not selected'
      else
        user = User.find(params[:user])
        invoice.user = user
      end
    else
      # Custom Email (Text-Field)
      invoice.invitation = true
      invoice.customer_email = params[:customer_email]
    end

    unless params[:invoice_note] == '(Optional) Invoice Note' || params[:invoice_note].empty?
      invoice.invoice_note = params[:invoice_note]
    end

    unless params[:request_amount].nil? || params[:request_amount] == 0.00 || !params[:request_amount] || params[:request_amount] == '(Optional) Request Amount' || params[:request_amount].empty?
      if ApplicationHelper.is_number? params[:request_amount]
        invoice.request_amount = params[:request_amount]
      else
        errors << 'Payment request amount must be a number.'
      end
    end
    invoice
  end
end