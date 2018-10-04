class ChargesController < ApplicationController
  before_action :require_stripe

  def generate_modal
    logger.debug("New Charges Controller")
    @error_msgs = Array.new

    @customer = current_user
    @project = Project.find(params[:project_id])
    @owner = @project.owner
    @amount = params[:charge_amount]
    # @amount = params[:amount]
    @amount = @amount.to_d
    @sprint = Sprint.find(params[:sprint_id])


    if (params[:charge_amount].number?)
      unless @owner.stripe_account_id.nil?
        if params[:payment_note] != 'Payment Note'
          @payment_note = params[:payment_note]
        else
          @payment_note = nil
        end
      else
        @error_msgs << 'Stripe account not connected to owner. Contact owner.'
        logger.error('Stripe account not connected for owner ' + @owner.email + ' and customer ' + @customer.email)
      end
    else
      @error_msgs << 'Error processing payment. Payment amount was not not a number or not selected.'
      logger.error('Payment Amount was not a number' + @owner.email + ' and customer ' + @customer.email)
    end

    respond_to do |format|
      format.js
      format.html
    end
  end

  def new
    logger.debug("New Charges Controller")
    @error_msgs = Array.new

    @customer = current_user
    @project = Project.find(params[:project_id])
    @owner = @project.owner
    @amount = params[:charge_amount]
    # @amount = params[:amount]
    @amount = @amount.to_d
    @sprint = Sprint.find(params[:sprint_id])


    if params[:charge_amount].number? && params[:sprint_id].number?
      unless @owner.stripe_account_id.nil?
        if params[:payment_note] != 'Payment Note'
          @payment_note = params[:payment_note]
        else
          @payment_note = nil
        end
      else
        @error_msgs << 'Stripe account not connected to owner. Contact owner.'
        logger.error('Stripe account not connected for owner ' + @owner.email + ' and customer ' + @customer.email)
      end
    else
      @error_msgs << 'Error processing payment. Sprint or Payment amount was not not a number ro not selected.'
      logger.error('Payment Sprint ID was not a number' + @owner.email + ' and customer ' + @customer.email)
    end

    respond_to do |format|
      format.js
      format.html
    end
  end

  def create
    logger.debub("Charges Create Controller")

    @error_msgs = Array.new

    @customer = current_user
    @project = Project.find(params[:project_id])
    @owner = @project.owner

    unless @owner.stripe_account_id.nil?

      @payment = Payment.new
      @payment.amount = params[:charge_amount]
      @payment.sprint = Sprint.find(params[:sprint_id])
      @payment.user = User.find(params[:customer_id])
      # @payment.type = params[:payment_type]
      if params[:payment_note] != 'Payment Note'
        @payment.payment_note = params[:payment_note]
      end
      @payment.save

      # TODO: Reference charge from payment model
      if @payment.valid?
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
            :on_behalf_of => @owner.stripe_account_id,
            :destination => {
                :amount => ENV['STRIPE_FEE'],
                :account => @owner.stripe_account_id,
            }
        )
        if charge.valid?
          Note.create_payment(@payment.sprint, current_user, @payment.amount) # TODO: Add an image or object to this note (not just a sentence)
        else
          charge.errors.full_messages do |error|
            logger.error('Error creating Stripe Charge: ' + error)
            @error_msgs << error
          end
        end
        if @payment.sprint.payment_due?
          @payment.sprint.payment_due = false
          @payment.sprint.save
          @payment.sprint.reload
        end
      else
        @payment.errors.full_messages.each do |error|
          logger.error('Payment error: ' + error)
          @error_msgs << error
        end
      end

    else
      @error_msgs << 'Owner is not prepared to received Stripe payments. Contact project owner / Jeweler support.'
      flash[:error] = 'Owner is not prepared to received Stripe payments. Contact project owner / Jeweler support.'
      logger.error('Stripe account not connected for owner ' + @owner.email + ' and customer ' + @customer.email)
    end

    respond_to do |format|
      format.js
      unless @error_msgs.empty?
        format.html {redirect_to project_path(@project), :flash => {:error => 'Payment Error: ' + @error_msgs.first}}
      else
        format.html {redirect_to project_path(@project), :notice => 'Payment of ' + @amount.to_s + ' made succesfully. Thank You.'}
      end
    end

  rescue Stripe::CardError => e
    @error = true
    flash[:error] = e.message
    logger.error('Charge Error for customer ' + @customer.email + ' and project ID ' + @project.id.to_s + ' Error Message: ' + e.message)
    respond_to do |format|
      format.js
      format.html {redirect_to project_path(@project), :flash => {:error => 'Error during payment. Contact support (Error logged).'}}
    end
  end

  protected

  def require_stripe
    require 'stripe'
  end

end
