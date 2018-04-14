class InvoiceItemsController < ApplicationController
  before_action :set_invoice_item, only: [:show, :edit, :update, :destroy]

  def complete_task
    @task = InvoiceItem.find(params[:invoice_item_id])

    logger.debug("Setting Task Complete, ID: " + @task.id.to_s)

    project = @task.invoice.project

    if @task.is_current?
      project.current_task = nil
      count = 1
      next_task = false
      until !project.current_task.nil? or (count >= @task.invoice.invoice_items.count)
        @task.invoice.invoice_items.sort_by(&:created_at).each do |t|
          if next_task
            if t.complete == false
              project.current_task = t
              project.save
              break
            end
          end
          if @task == t
            next_task = true
            count = 1
          end
          count = count + 1
        end
      end
    end

    @task.complete = true
    @task.save
    @task.reload
    @task.invoice.reload
    @invoice = @task.invoice

    if @invoice.sprint_complete?
      # TODO: Implement Close Sprint Upon Completion Feature Setting
      close_sprint_upon_completion_feature = false
      if close_sprint_upon_completion_feature
        if @invoice.open
          @invoice.open = false
          @invoice.save
        end
      end
    end

    respond_to do |format|
      format.js
    end
  end

  def uncomplete_task
    @task = InvoiceItem.find(params[:invoice_item_id])
    @task.complete = false
    @task.save
    @task.reload
    @task.invoice.reload
    @invoice = @task.invoice
    @invoice.reload

    respond_to do |format|
      format.js
    end
  end

  def cancel_update
    @invoice = Invoice.find(params[:invoice_id])

    respond_to do |format|
      format.js
    end
  end

  def edit_inline
    @task = InvoiceItem.find(params[:task_id])
    @invoice = @task.invoice

    if @task.nil?
      logger.error('Error getting Task ' + params[:task_id].to_s)
    else
      logger.debug('Task Fetched OK: ' + @task.id.to_s)
    end

    respond_to do |format|
      format.js
    end
  end

  def delete_inline
    @invoice_item = InvoiceItem.find(params[:task_id])

    logger.debug("Delete Task AJAX Task ID: " + @invoice_item.to_s)

    @invoice = @invoice_item.invoice

    Note.create_event(@invoice.project, current_user, 'Task Deleted: ' + @invoice_item.description)

    @current_sprint = @invoice.project.sprint_current

    @project = Project.find(@invoice.project.id)

    if @invoice.project.current_task == @invoice_item
      # @invoice.project.current_task.clear
    end

    # @invoice_item.notes.clear
    @invoice_item.destroy

    respond_to do |format|
      format.js
    end
  end

  def create_inline
    @invoice_id = params[:invoice_id]
    @invoice = Invoice.find(@invoice_id)

    logger.debug("Create Task Invoice ID: " + @invoice_id.to_s)

    respond_to do |format|
      format.js
    end
  end

  def save_inline
    @invoice = Invoice.find(params[:invoice_id])

    @current_sprint = @invoice.project.sprint_current

    @task = InvoiceItem.new
    @task.description = params[:description]

    if ApplicationHelper.is_number?(params[:hours])
      @task.hours = params[:hours]
    else
      # @task.hours = nil
    end

    if ApplicationHelper.is_number?(params[:planned_hours])
      @task.planned_hours = params[:planned_hours]
    else
      # @task.planned_hours = nil
    end

    @task.rate = params[:rate]
    @task.invoice = Invoice.find(params[:invoice_id])

    if @task.invoice.project.current_task.nil?
      @task.invoice.project.current_task = @task
    end

    @task.save
    @task.reload

    if @task.invoice.invoice_items.empty? && @task.invoice.project.current_task.nil?

      Note.create_event(@invoice.project, current_user, 'Task Created: ' + task.description)

      project = @task.invoice.project
      project.current_task = @task
      project.save
    end

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
        format.html {redirect_to @invoice_item, notice: 'Invoice item was successfully created.'}
        format.json {render :show, status: :created, location: @invoice_item}
      else
        format.html {render :new}
        format.json {render json: @invoice_item.errors, status: :unprocessable_entity}
      end
    end
  end

  def update_inline

    logger.debug("Updating Inline Task")

    @task = InvoiceItem.update(params)
    @task.save

    if @task.invalid?
      logger.error("Task not updated succesfully")
      logger.error(@task.errors)
    end

    Note.create_event(@project, current_user, 'Task Updated: ' + @task.description)

    respond_to do |format|
      format.js
    end
  end

  # PATCH/PUT /invoice_items/1
  # PATCH/PUT /invoice_items/1.json
  def update
    logger.info("Updating Task")
    respond_to do |format|
      if @invoice_item.update(invoice_item_params)
        @task = @invoice_item
        if @invoice_item.invalid?
          logger.error("Task not updated succesfully")
          logger.error(@task.errors)
        end

        Note.create_event(@project, current_user, 'Task Updated: ' + @task.description)

        format.html {redirect_to @invoice_item, notice: 'Invoice item was successfully updated.'}
        format.json {render :show, status: :ok, location: @invoice_item}
        format.js
      else
        format.js
        format.html {render :edit}
        format.json {render json: @invoice_item.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /invoice_items/1
  # DELETE /invoice_items/1.json
  def destroy
    @invoice_item.destroy
    respond_to do |format|
      format.html {redirect_to invoice_items_url, notice: 'Invoice item was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_invoice_item
    @invoice_item = InvoiceItem.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def invoice_item_params
    params.require(:invoice_item).permit(:description, :hours, :planned_hours, :rate, :complete,)
  end
end
