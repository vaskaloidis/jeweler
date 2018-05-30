# frozen_string_literal: true

class TasksController < ApplicationController
  include Task::Ajaxable

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
    @sprint = Sprint.find(params[:sprint_id])
    @task.sprint = @sprint
    logger.debug('Create Task Invoice ID: ' + @sprint_id.to_s)
  end

  def edit
    @sprint = @task.sprint

    logger.error('TasksController/Edit: Error getting Task ' + params[:id].to_s) if @task.nil?
  end

  def create
    @task = Task.new(task_params)
    @sprint = Sprint.find(@task.sprint.id)
    @current_sprint = @sprint.project.sprint_current

    @task.position = @task.sprint.next_position_int

    respond_to do |format|
      if @task.save

        if @task.sprint.tasks.empty? && @task.sprint.project.current_task.nil? && @task.sprint.current?
          project = @task.sprint.project
          project.current_task = @task
          project.save
          if project.invalid?
            project.errors.full_messages.log_errors('TasksController - Error changing Curent-Task')
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
end
