class InvoiceItemsController < ApplicationController
  before_action :set_invoice_item, only: [:show, :edit, :update, :destroy]

  def complete_task
    logger.debug("** Completing Task **")
    @task = InvoiceItem.find(params[:invoice_item_id])

    @task.invoice.project.create_event('task_completed', 'Complete: ' + @task.description)

    @task.complete = true
    @task.save
    @task.reload

    logger.debug("Setting Task Complete, ID: " + @task.id.to_s)

    # Select Next Task Algorithm
    if @task.is_current?
      logger.debug("** Current Task")
      @task.invoice.project.current_task = nil
      @task.invoice.project.save
      @next_task = false
      logger.debug("@task.invoice.incomplete_tasks.empty? " + @task.invoice.incomplete_tasks.empty?.to_s)
      logger.debug("!@task.invoice.project.current_task.nil? " + (!@task.invoice.project.current_task.nil?).to_s)
      until !@task.invoice.project.current_task.nil? or @task.invoice.incomplete_tasks.empty?
        logger.debug("** Loop")
        @task.invoice.tasks.each do |task|
          if @next_task
            logger.debug("** Next Task")
            if task.complete == false
              logger.debug("** Task Not Complete. Let's use this. ")
              @task.invoice.project.current_task = task
              @task.invoice.project.save
              @task.invoice.project.reload
              break
            end
          elsif @task == task && !@next_task
            logger.debug("** Found Current Task")
            @next_task = true
          end
        end
      end
    end

    @invoice = @task.invoice

    if @invoice.sprint_complete?
      # Do We Want To Close Sprint Upon Completion Feature? No, we make it a setting
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

  def index
    @invoice_items = InvoiceItem.all
  end

  def show
  end

  def new
    @invoice_item = InvoiceItem.new
    @invoice_id = params[:invoice_id]
    @invoice = Invoice.find(@invoice_id)
    @invoice_item.invoice = @invoice

    logger.debug("Create Task Invoice ID: " + @invoice_id.to_s)

    respond_to do |format|
      format.js
      format.html {render :edit}
    end
  end

  def edit
    @invoice = @invoice_item.invoice

    if @invoice_item.nil?
      logger.error('Error getting Task ' + params[:id].to_s)
    else
      logger.debug('Task Fetched OK: ' + @invoice_item.id.to_s)
    end

    respond_to do |format|
      format.js
      format.html {render :edit}
    end
  end

# POST /invoice_items
# POST /invoice_items.json
  def create
    @error_msgs = Array.new
    @invoice_item = InvoiceItem.new(invoice_item_params)

    # @invoice = Invoice.find(params.require(:invoice_item).require(:invoice_id))
    @invoice = Invoice.find(@invoice_item.invoice_id)
    @current_sprint = @invoice.project.sprint_current

    # @invoice_item = InvoiceItem.new
    # @invoice_item.description = params.require(:invoice_item).require(:description)
    # hours = params.require(:invoice_item).permit(:hours)
    # if ApplicationHelper.is_number?(hours)
    #   @invoice_item.hours = hours
    # else
    #   @error_msg << 'Reported hours must be a number'
    #   # @invoice_item.hours = nil
    # end
    # planned_hours = params.require(:invoice_item).require(:planned_hours)
    # if ApplicationHelper.is_number?(planned_hours)
    #   @invoice_item.planned_hours = planned_hours
    # else
    #   @error_msg << 'Reported hours must be a number'
    #   # @invoice_item.planned_hours = nil
    # end
    # rate = params.require(:invoice_item).require(:rate)
    # @invoice_item.rate = rate
    # @invoice_item.invoice = @invoice

    if @invoice_item.invoice.project.current_task.nil?
      @invoice_item.invoice.project.current_task = @invoice_item
    end

    @invoice_item.position = @invoice_item.invoice.next_position_int

    if @invoice_item.invoice.tasks.empty? and @invoice_item.invoice.project.current_task.nil? and @invoice_item.invoice.is_current?
      project = @invoice_item.invoice.project
      project.current_task = @invoice_item
      project.save
      if project.invalid?
        project.error.full_messages.each do |error|
          @error_msg << error
          # logger.error('Error creating new task: ' + error)
        end
      end
      @invoice_item.invoice.project.reload
    end

    respond_to do |format|
      if @invoice_item.save

        if @invoice_item.valid?
          Note.create_event(@invoice.project, 'task_created', 'Task Created: ' + @invoice_item.description)
        else
          @invoice_item.errors.full_messages.each do |error|
            @error_msg << error
            logger.error("Error Creating Task: " + @invoice_item.error.full_message)
          end
        end

        format.js
        format.html {redirect_to @invoice_item, notice: 'Invoice item was successfully created.'}
        format.json {render :show, status: :created, location: @invoice_item}
      else
        format.js
        format.html {render :new}
        format.json {render json: @invoice_item.errors, status: :unprocessable_entity}
      end
    end
  end

  def update
    respond_to do |format|

      if @invoice_item.update(invoice_item_params)

        @task = @invoice_item
        if @invoice_item.invalid?
          logger.error("Task not updated succesfully: " + @invoice_item.errors.full_message)
        end

        Note.create_event(@task.invoice.project, 'task_updated', 'Updated: ' + @task.description)

        format.js
        format.html {redirect_to @invoice_item, notice: 'Invoice item was successfully updated.'}
        format.json {render :show, status: :ok, location: @invoice_item}
      else
        format.js
        format.html {render :edit}
        format.json {render json: @invoice_item.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy

    # @invoice_item.destroy
    #
    Note.create_event(@invoice_item.invoice.project, 'task_deleted', 'Deleted: ' + @invoice_item.description)
    @invoice_item.deleted = true
    @invoice_item.save
    @invoice_item.reload

    respond_to do |format|
      format.html {redirect_to invoice_items_url, notice: 'Invoice item was successfully destroyed.'}
      format.json {head :no_content}
      format.js
    end
  end

  private

  def set_invoice_item
    @invoice_item = InvoiceItem.find(params[:id])
  end

  def invoice_item_params
    params.require(:invoice_item).permit(:invoice_id, :description, :hours, :deleted, :position, :planned_hours, :rate, :complete,)
  end

end
