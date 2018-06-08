# The controller for building and configuring Sprint Invoices. This controller has
#  actions to generate a Sprint's Invoice, choose a customer, print or send.
class InvoicesController < ApplicationController
  before_action :set_sprint
  respond_to :html, only: %i[print]
  respond_to :js, except: %i[print]

  def generate
    @invoice = Invoice.new(sprint: @sprint,
                           estimate: @estimate,
                           display_send_btn: true,
                           display_print_btn: true,
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

  def send
    @customer_email = params[:customer_email]

    @invitation = params[:invitation].to_b
    @invoice_note = params[:invoice_note]
    @display_payments = params[:display_payments]
    @request_amount = params[:payment_request_amount]

    @customer_param = params[:customer]
    if @customer_param.to_b and !@customer_param.nil? and @customer_param != ''
      @customer = User.find(params[:customer])
    else
      @customer = false
    end

    unless @invoice_note.to_b
      @invoice_note = false
    end

    unless @customer_email.to_b
      @customer_email = false
    end

    unless @request_amount.to_b and @request_amount != 0.00
      @request_amount = false
    end

    if @invitation
      if @customer_email
        if Invitation.where(email: @customer_email).empty?
          jeweler_invitation = Invitation.new
          jeweler_invitation.project = @sprint.project
          jeweler_invitation.email = @customer_email
          jeweler_invitation.save
          UserInviteMailer.with(email: @customer_email, project: @sprint.project.id).invite_user.deliver_now
        end
      else
        if Invitation.where(email: @customer.email).empty?
          jeweler_invitation = Invitation.new
          jeweler_invitation.project = @sprint.project
          jeweler_invitation.email = @customer_email
          jeweler_invitation.save
          UserInviteMailer.with(email: @customer.email, project: @sprint.project.id).invite_user.deliver_now
        end
      end


    end
  end

  def review
    @customer_email = params[:customer_email]
    @invoice_note = params[:invoice_note]
    @display_payments = params[:display_payments] == "1"
    @request_amount = params[:request_amount]

    # Parse
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

  def print
    render partial: 'invoices/generate_printable_invoice',
           locals: {sprint_id: @sprint,
                    estimate: @estimate,
                    display_send_btn: false,
                    display_pay_btn: false,
                    display_print_btn: false},
           layout: 'print'
  end

  private

  def set_sprint
    @sprint = Sprint.find(params[:id])
    @estimate = params[:estimate].to_b
  end

  def invoice_params
    params.require(:invoice).permit(:sprint, :estimate, :display_send_btm, :display_pay_btn, :display_print_btn, :request_amount, :invoice_note, :display_payments, :customer, :customer_email)
  end

end
