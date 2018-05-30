module Task::Ajaxable
  extend ActiveSupport::Concern

  included do
    before_action :prepare_errors
    after_action :log_errors
    before_action :set_task, only: %i[show edit update destroy complete_task uncomplete_task cancel_update]
    # respond_to :json, :html, only: %i[show edit update destroy]
    respond_to :js, only: %i[complete_task uncomplete_task cancel_update
                             new create edit update destroy]
  end

  def complete_task
    @task.sprint.project.create_event('task_completed', 'Complete: ' + @task.description)

    @task.complete = true
    @task.save
    @task.reload

    # Select Next Task Algorithm
    if @task.current?
      @task.sprint.project.current_task = nil
      @task.sprint.project.save
      @next_task = false
      until !@task.sprint.project.current_task.nil? or @task.sprint.incomplete_tasks.empty?
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

  def uncomplete_task
    @task.complete = false
    @task.save
    @task.reload
    @task.sprint.reload
    @sprint = @task.sprint_id
    @sprint.reload

  end

  def cancel_update
    @sprint = Sprint.find(params[:sprint_id])
  end

  private

  def set_task
    @task = Task.find(params[:id])
    @sprint = @task.sprint
  end

  def prepare_errors
    @errors = Array.new
  end

  def log_errors
    unless @errors.empty?
      @errors.each do |e|
        logger.error 'TasksController Error: ' + e
      end
    end
  end

  def task_params
    params.require(:task).permit(:sprint_id, :sprint, :description, :hours, :deleted, :position, :planned_hours, :rate, :complete,)
  end
end
