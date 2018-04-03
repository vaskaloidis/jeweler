class InvoiceItemsController < ApplicationController
  before_action :set_invoice_item, only: [:show, :edit, :update, :destroy]

  def create_task_inline

    @invoice_id = params[:invoice_id]


    respond_to do |format|
      format.js
    end

  end

  def save_task_inline
    @invoice_id = params[:invoice_id]

    @task = InvoiceItem.new
    @task.description = params[:description]
    @task.hours = params[:hours]
    @task.rate = params[:rate]
    @task.invoice = Invoice.find(params[:invoice_id])
    @task.save

    respond_to do |format|
      format.js
    end

  end

  # GET /invoice_items
  # GET /invoice_items.json
  def index
    @invoice_items = InvoiceItem.all
  end

  # GET /invoice_items/1
  # GET /invoice_items/1.json
  def show
  end

  # GET /invoice_items/new
  def new
    @invoice_item = InvoiceItem.new
  end

  # GET /invoice_items/1/edit
  def edit
  end

  # POST /invoice_items
  # POST /invoice_items.json
  def create
    @invoice_item = InvoiceItem.new(invoice_item_params)

    respond_to do |format|

      @invoice_item.invoice.project.create_note('project_update', 'Created Task for Sprint ' + @invoice_item.invoice.sprint.to_s)

      if @invoice_item.save
        format.html { redirect_to @invoice_item, notice: 'Invoice item was successfully created.' }
        format.json { render :show, status: :created, location: @invoice_item }
      else
        format.html { render :new }
        format.json { render json: @invoice_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invoice_items/1
  # PATCH/PUT /invoice_items/1.json
  def update
    respond_to do |format|
      if @invoice_item.update(invoice_item_params)
        format.html { redirect_to @invoice_item, notice: 'Invoice item was successfully updated.' }
        format.json { render :show, status: :ok, location: @invoice_item }
      else
        format.html { render :edit }
        format.json { render json: @invoice_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoice_items/1
  # DELETE /invoice_items/1.json
  def destroy
    @invoice_item.destroy
    respond_to do |format|
      format.html { redirect_to invoice_items_url, notice: 'Invoice item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice_item
      @invoice_item = InvoiceItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invoice_item_params
      params.require(:invoice_item).permit(:description, :hours, :rate, :item_type, :complete, :belongs_to)
    end
end
