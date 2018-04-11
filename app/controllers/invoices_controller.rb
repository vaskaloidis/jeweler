class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]

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

  def make_payment

    respond_to do |format|
      format.js
    end
  end

  def set_current_task
    @task = InvoiceItem.find(params[:invoice_item_id])
    @invoice = @task.invoice

    logger.debug("Setting Task " + @task.id.to_s + " for Invoice " + @invoice.id.to_s)

    @project = @invoice.project
    @project.current_task = @task
    @project.save

    @project.reload
    @task.reload
    @invoice = @task.invoice

    if @project.valid?
      Note.create_event(@project, current_user, 'Current Task Changed')
    else
      logger.error("Error Changing Current Task From to ID: " + @task.id.to_s)
    end

    @current_sprint = @project.sprint_current
    respond_to do |format|
      format.js
    end
  end


  def set_current_sprint
    @invoice = Invoice.find(params[:invoice_id])

    logger.debug("Setting Current Invoice " + @invoice.id.to_s)

    @project = Project.find(@invoice.project.id)
    @old_invoice = @project.current_sprint
    @project.current_sprint(@invoice)

    @project.reload
    @invoice.reload

    if @project.valid?
      Note.create_event(@project, current_user, 'Current Sprint Changed')
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

    Note.create_event(@sprint.project, current_user, 'Sprint ' + @sprint.sprint.to_s + ' Opened ')

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

    Note.create_event(@sprint.project, current_user, 'Sprint ' + @sprint.sprint.to_s + ' Closed ')

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
    @invoices = Invoice.all
  end

  # GET /invoices/1
  # GET /invoices/1.json
  def show
    @invoice = Invoice.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def generate_invoice
    @invoice = Invoice.find(params[:id])
    respond_to do |format|
      format.js
    end
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
      else
        format.html {render :edit}
        format.json {render json: @invoice.errors, status: :unprocessable_entity}
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
  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def invoice_params
    params.require(:invoice).permit(:sprint, :payment_due_date, :payment_due, :description, :belongs_to)
  end
end
