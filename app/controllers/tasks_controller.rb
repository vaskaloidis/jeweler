# frozen_string_literal: true

# Controller to handle all the Task Actions, for the Tasks that makeup each sprint
class TasksController < ApplicationController
  before_action :set_sprint, only: %i[index new cancel]
  before_action :set_task, only: %i[show edit update destroy complete uncomplete set_current]
  after_action :handle_service_object, only: %i[complete uncomplete destroy set_current]
  respond_to :js, :json, only: %i[complete uncomplete cancel new show create edit update destroy]

  def index
    @tasks = @sprint.tasks
  end

  def new
    @task = @sprint.tasks.build
  end

  def show; end

  def edit; end

  def create
    @service_object = CreateTask.call(task_params)
    @task = @service_object.result
    @errors = @service_object.errors
    respond_to do |format|
      format.js
      if @service_object.result.valid?
        format.json {render :show, status: :created, location: @service_object.result}
      else
        format.json {render json: @service_object.errors, status: :unprocessable_entity}
      end
    end
  end

  def update
    @task.update(task_params)
    @task.errors.full_messages.map {|e| @errors << 'Error Creating task: ' + e} if @task.invalid?
    respond_to do |format|
      format.js
      if @task.valid?
        # TODO: Note.create_event(@task.sprint.project, 'task_updated', 'Updated: ' + @task.description)
        format.json {render :show, status: :ok, location: @task}
      else
        format.json {render json: @task.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @service_object = DestroyTask.call(@task)
    @task.reload
    respond_to do |format|
      format.js
      format.json {head :no_content}
    end
  end

  def set_current
    @service_object = SetCurrentTask.call(@task)
  end

  def complete
    @service_object = CompleteTask.call(@task)
  end

  def uncomplete
    @service_object = UnCompleteTask.call(@task)
  end

  def cancel; end

  private

  def set_task
    @task = Task.find(params[:id])
    @sprint = @task.sprint
  end

  def set_sprint
    @sprint = Sprint.find(params[:sprint_id])
  end

  def handle_service_object
    @task = @service_object.result
    @errors = @service_object.errors
  end

  def task_params
    params.require(:task).permit(:sprint_id, :open, :sprint, :description, :hours, :deleted, :planned_hours, :rate, :complete, :created_by_id, :assigned_to_id)
  end
end
