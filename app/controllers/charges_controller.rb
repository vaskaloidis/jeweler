class ChargesController < ApplicationController
  before_action :require_stripe

  def new
    @error = false

    @customer = current_user
    @project = Project.find(params[:project_id])
    @owner = @project.owner

    if ApplicationHelper.is_number?(params[:amount]) and ApplicationHelper.is_number?(params[:invoice_id])

      @amount = params[:amount].to_d

      unless @owner.stripe_account_id.nil?

        @invoice = Invoice.find(params[:invoice_id])
        @user_id = params[:user_id]
        if params[:payment_note] != 'Payment Note'
          @payment_note = params[:payment_note]
        else
          @payment_note = nil
        end
      else
        @error = true
        @error_msg = 'Stripe account not connected to owner. Contact owner.'
        logger.error('Stripe account not connected for owner ' + @owner.email + ' and customer ' + @customer.email)
      end
    else
      if !ApplicationHelper.is_number?(params[:amount])
        @error = true
        @error_msg = 'Payment amount was not a number.'
        logger.error('Payment amount was not a number ' + @owner.email + ' and customer ' + @customer.email)
      end
      if ApplicationHelper.is_number?(params[:invoice_id])
        @error = true
        @error_msg = 'You must select a sprint to make a payment against.'
        logger.error('Payment Sprint ID was not a number' + @owner.email + ' and customer ' + @customer.email)
      end
    end

    respond_to do |format|
      format.js
    end
  end

  def create
    @error = false

    if ApplicationHelper.is_number?(params[:amount])
      @customer = current_user
      @project = params[:project_id]
      @owner = @project.owner

      unless @owner.stripe_customer_id.nil?

        @payment = Payment.new
        @payment.amount = params[:amount]
        @payment.invoice = Invoice.find(params[:invoice_id])
        @payment.user = User.find(params[:customer_id])
        @payment.type = User.find(params[:payment_type])
        if params[:payment_note] != 'Payment Note'
          @payment.payment_note = params[:payment_note]
        end
        @payment.save

        customer = Stripe::Customer.create(
            :email => params[:stripeEmail],
            :source => params[:stripeToken]
        )

        # Stripe.api_key = @owner.stripe_token

        charge = Stripe::Charge.create(
            :customer => customer.id,
            :amount => @payment.amount * 100,
            :currency => 'usd',
            :description => 'Jeweler Project ' + @project.name + ' Invoicing',
            :on_behalf_of => @owner.stripe_customer_id,
            :destination => {
                :amount => ENV['STRIPE_FEE'],
                :account => @owner.stripe_customer_id,
            }
        )

        # TODO: Reference charge from payment model
        if @payment.valid?
          if @payment.invoice.payment_due?
            @payment.invoice.payment_due = false
            @payment.invoice.save
            @payment.invoice.reload
          end
        end

        if @payment.valid?
          # TODO: Add an image or object to this note (not just a sentence)
          Note.create_payment(@payment.invoice, current_user, @payment.amount)
        else
          logger.error('Payment Error User ID: ' + @payment.user.id.to_s + ' Project ID: ' + @payment.invoice.project.id.to_s + ' Sprint ' + @payment.invoice.sprint.to_s)
        end

      else
        @error = true
        @error_msg = 'Stripe account not connected to owner. Contact owner.'
        flash[:error] = @error_msg
        logger.error('Stripe account not connected for owner ' + @owner.email + ' and customer ' + @customer_email)
      end

    else
      @error = true
      @error_msg = 'Payment amount was not a number.'
      flash[:error] = @error_msg
      logger.error('Payment amount was not a number ' + @owner.email + ' and customer ' + @customer_email)
    end

    render(:layout => "application")
    respond_to do |format|
      format.js
      if @error
        format.html { redirect_to project_path(@project), :flash => { :error => @error_msg } }
      else
        format.html { redirect_to project_path(@project), :notice => 'Payment of ' + @amount.to_s + ' made succesfully. Thank You.' }
      end
    end

  rescue Stripe::CardError => e
    @error = true
    flash[:error] = e.message
    logger.error('Charge Error for customer ' + @customer.email + ' and project ID ' + @project.id.to_s + ' Error Message: ' + e.message)
    render(:layout => "application")
    respond_to do |format|
      format.js
      format.html { redirect_to new_charge_path, :flash => { :error => 'Error during payment. Contact support.' } }
    end
  end

  protected

  def require_stripe
    require 'stripe'
  end

end
