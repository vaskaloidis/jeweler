class InvoicesController < ApplicationController
  before_action :set_objects, only: [:show, :edit, :update, :destroy]

  def send_invoice
    @invoice = Invoice.find(params[:invoice_id])
    @estimate = params[:estimate].to_b
    @customer_email = params[:customer_email]

    @invitation = params[:invitation].to_b
    @invoice_note = params[:invoice_note]
    @display_payments = params[:display_payments]
    @request_amount = params[:payment_request_amount]
    @estimate = params[:estimate].to_b

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
          jeweler_invitation.project = @invoice.project
          jeweler_invitation.email = @customer_email
          jeweler_invitation.save
          UserInviteMailer.with(email: @customer_email, project: @invoice.project.id).invite_user.deliver_now
        end
      else
        if Invitation.where(email: @customer.email).empty?
          jeweler_invitation = Invitation.new
          jeweler_invitation.project = @invoice.project
          jeweler_invitation.email = @customer_email
          jeweler_invitation.save
          UserInviteMailer.with(email: @customer.email, project: @invoice.project.id).invite_user.deliver_now
        end
      end


    end

    respond_to do |format|
      format.js
    end
  end

  def review_customer_invoice
    @error_msgs = Array.new

    @invoice = Invoice.find(params[:invoice_id])
    @estimate = params[:estimate].to_b
    @customer_email = params[:customer_email]
    @invoice_note = params[:invoice_note]
    @display_payments = params[:display_payments] == "1"
    @request_amount = params[:request_amount]
    @estimate = params[:estimate].to_b

    if @customer_email == 'Customer Email' or @customer_email == ''
      # Email Dropdown
      if params[:customer_id].nil? or params[:customer_id] == ''
        @error_msgs << 'A customer was not selected'
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
            @error_msgs << 'Payment request amount must be a number (or leave it empty)'
          end
        end
      end
    end

    respond_to do |format|
      format.js
    end
  end

  def generate_customer_invoice
    @invoice = Invoice.find(params[:invoice_id])
    @estimate = params[:estimate].to_b

    respond_to do |format|
      format.js
    end
  end

  def generate_invoice
    @invoice = Invoice.find(params[:invoice_id])
    @estimate = params[:estimate].to_b
    logger.debug("Estimate: " + @estimate.to_s)
    logger.debug("Invoice ID: " + @invoice.id.to_s)
    respond_to do |format|
      format.js
    end
  end

  def print_invoice
    @invoice = Invoice.find(params[:invoice_id])
    @estimate = params[:estimate].true?
    render partial: 'invoices/generate_printable_invoice',
           locals: {invoice: @invoice,
                    estimate: @estimate,
                    display_send_btn: false,
                    display_pay_btn: false,
                    display_print_btn: false},
           layout: 'print'
  end

  def edit_description
    @invoice = Invoice.find(params[:invoice_id])
    respond_to do |format|
      format.js
    end
  end

  def render_panel
    @invoice = Invoice.find(params[:invoice_id])
    respond_to do |format|
      format.js
    end
  end

  def open_sprint_payment
    @invoice = Invoice.find(params[:invoice_id])
    respond_to do |format|
      format.js
    end
  end

  def open_payment
    @project = Project.find(params[:project_id])
    respond_to do |format|
      format.js
    end
  end

  def set_current_task
    @task = InvoiceItem.find(params[:invoice_item_id])
    @old_task = @task.invoice.project.current_task

    if @task.invoice != @task.invoice.project.current_sprint
      @error = true
      @error_message = 'Current Task must be within Current Sprint.'
      logger.debug('Error: ' + @error_message)
    else
      logger.debug('No Errors')
      @error = false
      unless @old_task.nil? or @old_task.complete
        @old_task.complete = true
        @old_task.save
        @old_task.reload
      end

      @task.invoice.project.current_task = @task
      @task.invoice.project.save
      @task.invoice.project.reload
      @task.invoice.reload

      if @task.complete? != false
        @task.complete = false
        @task.save
        @task.reload
      end

      if @task.invoice.closed?
        @task.invoice.open = true
        @task.invoice.save
      end

      @current_sprint = @task.invoice.project.sprint_current

    end
    if @task.invoice.project.valid?
      Note.create_event(@task.invoice.project, 'current_task_changed', 'Current Task: ' + @task.description)
    else
      @error = true
      @@error_message = "Error changing current task."
      logger.error("Error Changing Current Task From to ID: " + @task.id.to_s)
    end

    logger.debug("Setting Task " + @task.id.to_s + " for Invoice " + @task.invoice.id.to_s)

    respond_to do |format|
      format.js
    end
  end


  def set_current_sprint
    @invoice = Invoice.find(params[:invoice_id])

    logger.debug("Setting Current Invoice " + @invoice.id.to_s)

    @project = Project.find(@invoice.project.id)
    @old_invoice = @project.current_sprint
    @project.current_sprint = @invoice

    unless @project.current_task.nil?
      @project.current_task = nil
    end
    @project.save
    @project.reload
    @invoice.reload
    @old_invoice.reload

    if @project.valid?
      Note.create_event(@project, 'current_sprint_changed', 'Current Sprint Changed From ' + @old_invoice.sprint.to_s + ' to ' + @invoice.sprint.to_s)
    else
      logger.error("Error Changing Current Sprint From " + @old_invoice.sprint.to_s + " to " + @invoice.sprint.to_s)
    end

    @current_sprint = @project.sprint_current
    respond_to do |format|
      format.js
    end
  end

  def open_sprint_inline
    @sprint = Invoice.find(params[:invoice_id])
    @sprint.open = true
    @sprint.save

    Note.create_event(@sprint.project, 'sprint_opened', 'Sprint ' + @sprint.sprint.to_s + ' Opened ')

    if @sprint.invalid?
      logger.error("Sprint " + @sprint.sprint.to_s + " could not be opened. ID: " + @sprint.id.to_s)
      logger.error(@sprint.errors)
    end

    @sprint.reload

    respond_to do |format|
      format.js
    end
  end

  def close_sprint_inline
    @sprint = Invoice.find(params[:invoice_id])
    @sprint.open = false
    @sprint.save

    Note.create_event(@sprint.project, 'sprint_closed', 'Sprint ' + @sprint.sprint.to_s + ' Closed ')

    if @sprint.invalid?
      logger.error("Sprint " + @sprint.sprint.to_s + " could not be closed. ID: " + @sprint.id.to_s)
      logger.error(@sprint.errors)
    end

    @sprint.reload

    respond_to do |format|
      format.js
    end
  end

  # GET /invoices
  # GET /invoices.json
  def index
    @project = Project.find(params[:project_id])
  end

  # GET /invoices/1
  # GET /invoices/1.json
  def show
    @invoice = Invoice.find(params[:id])
  end

  # GET /invoices/new
  def new
    @invoice = Invoice.new
  end

  # GET /invoices/1/edit
  def edit
  end

  # POST /invoices
  # POST /invoices.json
  def create
    @invoice = Invoice.new(invoice_params)

    respond_to do |format|
      if @invoice.save

        @invoice.project.create_note('project_update', 'Created Sprint ' + @invoice.sprint.to_s)

        format.html {redirect_to @invoice, notice: 'Invoice was successfully created.'}
        format.json {render :show, status: :created, location: @invoice}
      else
        format.html {render :new}
        format.json {render json: @invoice.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /invoices/1
  # PATCH/PUT /invoices/1.json
  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html {redirect_to @invoice, notice: 'Invoice was successfully updated.'}
        format.json {render :show, status: :ok, location: @invoice}
        format.js
      else
        format.html {render :edit}
        format.json {render json: @invoice.errors, status: :unprocessable_entity}
        format.js
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.json
  def destroy
    @invoice.destroy
    respond_to do |format|
      format.html {redirect_to invoices_url, notice: 'Invoice was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_objects
    @invoice = Invoice.find(params[:id])
    @project = @invoice.project
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def invoice_params
    params.require(:invoice).permit(:sprint, :payment_due_date, :payment_due, :description, :belongs_to)
  end
end
