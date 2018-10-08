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


    if params[:customer_email].nil?
      invoice.user = if params[:user_id].nil?
                       User.find(params[:user])
                     else
                       User.find(params[:user_id])
                     end
    elsif (params[:customer_email] == 'Customer Email' || params[:customer_email] == '') && (!params[:user].nil? || !params[:user_id].nil?)
      invoice.user = if params[:user_id].nil?
                       User.find(params[:user])
                     else
                       User.find(params[:user_id])
                     end
    elsif params[:customer_email]
      invoice.invitation = true
      invoice.customer_email = params[:customer_email]
    else
      errors << 'A customer was not selected'
    end

    unless params[:invoice_note].nil?
      unless params[:invoice_note] == '(Optional) Invoice Note' || params[:invoice_note] == ''
        invoice.invoice_note = params[:invoice_note]
      end
    end

    unless params[:request_amount].nil?
      unless params[:request_amount] == 0.00 || params[:request_amount] == '(Optional) Request Amount' || params[:request_amount] == ''
        if params[:request_amount].number?
          invoice.request_amount = params[:request_amount]
        else
          errors << 'Payment request amount must be a number.'
        end
      end
    end
    invoice
  end
end