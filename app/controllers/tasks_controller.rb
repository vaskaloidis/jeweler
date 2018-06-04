# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy complete
                                    uncomplete set_current]
  respond_to :js, :json, only: %i[complete uncomplete cancel
                                  new show create edit update destroy]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
    @sprint = Sprint.find(params[:sprint_id])
    @task.sprint = @sprint
  end

  def show; end

  def edit
    @sprint = @task.sprint
  end

  def create
    @task = Task.new(task_params)
    @sprint = Sprint.find(@task.sprint.id)
    @current_sprint = @sprint.project.sprint_current

    @task.position = @task.sprint.next_position_int

    respond_to do |format|
      if @task.save

        # Set Current Task if none, and is first Sprint Task created
        if @task.sprint.tasks.empty? && @task.sprint.project.current_task.nil? && @task.sprint.current?
          project = @task.sprint.project
          project.current_task = @task
          project.save
          if project.invalid?
            project.errors.full_messages.log_errors('TasksController - Error changing current-Task')
          end
          @task.sprint.project.reload
        end

        if @task.valid?
          Note.create_event(@sprint.project, 'task_created', 'Task Created: ' + @task.description)
        else
          @task.errors.full_messages.map { |e| @errors << 'Error Creating Task: ' + e }
        end
        format.js
        format.json { render :show, status: :created, location: @task }
      else
        @task.errors.full_messages.map { |e| @errors << 'Error Creating Task: ' + e }
        format.js
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        # Note.create_event(@task.sprint.project, 'task_updated', 'Updated: ' + @task.description) # TODO: Create an event note here
        format.js
        format.json { render :show, status: :ok, location: @task }
      else
        @task.errors.full_messages.map { |e| @errors << 'Error Updating Invoice: ' + e }
        format.js
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    Note.create_event(@task.sprint.project, 'task_deleted', 'Deleted: ' + @task.description)

    @task.deleted = true
    @task.save
    @task.reload

    if @task.invalid?
      @task.errors.full_messages.map { |e| @errors << 'Error Destroying Invoice: ' + e }

    end

    respond_to do |format|
      format.js
      format.json { head :no_content }
    end
  end

  def set_current
    @old_task = @task.sprint.project.current_task

    if @task.sprint != @task.sprint.project.current_sprint
      @error = true
      @error_message = 'Current Task must be within Current Sprint.'
      logger.debug('Error: ' + @error_message)
    else
      logger.debug('No Errors')
      @error = false
      unless @old_task.nil? || @old_task.complete
        @old_task.complete = true
        @old_task.save
        @old_task.reload
      end

      @task.sprint.project.current_task = @task
      @task.sprint.project.save
      @task.sprint.project.reload
      @task.sprint.reload

      if @task.complete? != false
        @task.complete = false
        @task.save
        @task.reload
      end

      if @task.sprint.closed?
        @task.sprint.open = true
        @task.sprint.save
      end

      @current_sprint = @task.sprint.project.sprint_current

    end
    if @task.sprint.project.valid?
      Note.create_event(@task.sprint.project, 'current_task_changed', 'Current Task: ' + @task.description)
    else
      @error = true
      @error_message = 'Error changing current task.'
      logger.error('Error Changing Current Task From to ID: ' + @task.id.to_s)
    end

    logger.debug('Setting Task ' + @task.id.to_s + ' for Invoice ' + @task.sprint.id.to_s)
  end

  def complete
    @task.sprint.project.create_event('task_completed', 'Complete: ' + @task.description)

    @task.complete = true
    @task.save
    @task.reload

    # Select Next Task Algorithm
    if @task.current?
      @task.sprint.project.current_task = nil
      @task.sprint.project.save
      @next_task = false
      until !@task.sprint.project.current_task.nil? || @task.sprint.incomplete_tasks.empty?
        @task.sprint.tasks.each do |task|
          if @next_task
            if task.complete == false
              @task.sprint.project.current_task = task
              @task.sprint.project.save
              @task.sprint.project.reload
              break
            end
          elsif @task == task && !@next_task
            @next_task = true
          end
        end
      end
    end

    @sprint = @task.sprint

    if @sprint.sprint_complete?
      # Do We Want To Close Sprint Upon Completion Feature? No, we make it a setting
      close_sprint_upon_completion_feature = false
      if close_sprint_upon_completion_feature
        if @sprint.open
          @sprint.open = false
          @sprint.save
        end
      end
    end
  end

  def uncomplete
    @task.complete = false
    @task.save
    @task.reload
    @task.sprint.reload
    @sprint = @task.sprint
    @sprint.reload
  end

  def cancel
    @sprint = Sprint.find(params[:sprint_id])
  end

  private

  def set_task
    @task = Task.find(params[:id])
    @sprint = @task.sprint
  end

  def task_params
    params.require(:task).permit(:sprint_id, :sprint, :description, :hours, :deleted, :position, :planned_hours, :rate, :complete)
  end
end
