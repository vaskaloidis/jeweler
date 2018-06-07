# An Invoice is simply a group of configuration settings for a Sprint
class Invoice
  include Virtus.model
  attribute :sprint, Sprint
  attribute :estimate, Boolean, default: false
  attribute :display_print_btn, Boolean, default: false
  attribute :display_pay_btn, Boolean, default: true
  attribute :display_send_btn, Boolean, default: false
  attribute :customer, User, default: false
  attribute :customer_email, String, default: false
  attribute :payment_request_amount, Float, default: false
  attribute :display_payments, Boolean, default: false
  attribute :invoice_note, String, default: false
  attribute :goal, String, default: false

  def parse_form!
    if @customer_email == 'Customer Email' or @customer_email == ''
      # Email Dropdown
      if params[:customer_id].nil? or params[:customer_id] == ''
        @errors << 'A customer was not selected'
      else
        @customer = User.find(params[:customer_id])
        @customer_email = false
        @recipient = @customer.email
      end
    else
      # Custom Email (Text-Field)
      @customer = false
      @invitation = true
      @recipient = @customer_email
    end

    if @invoice_note == '(Optional) Invoice Note' or @invoice_note == ''
      @invoice_note = false
    end

    if @request_amount.nil? or @request_amount == 0.00 or !@request_amount
      @request_amount = false
    else
      if @request_amount == '(Optional) Request Amount' or @request_amount == ''
        @request_amount = false
      else
        if @request_amount != '(Optional) Request Amount' and @request_amount != ''
          if !ApplicationHelper.is_number? @request_amount
            @errors << 'Payment request amount must be a number (or leave it empty)'
          end
        end
      end
    end
  end

end