# frozen_string_literal: true

class CreateTask < Jeweler::ServiceObject
  def initialize(task_params)
    @task = Task.new(task_params)
  end

  def call
    sprint = Sprint.find(task.sprint.id)
    task.position = task.sprint.next_position_int
    if task.save
      # Set Current task if none, and is first Sprint task created
      if task.sprint.tasks.empty? && task.sprint.project.current_task.nil? && task.sprint.current?
        project = task.sprint.project
        project.current_task = task
        project.save
        if project.invalid?
          errors << 'Error while setting this as the current-task'
          project.errors.full_messages.log_errors('CreateTaskSO - Error setting current-task after create')
        end
        task.sprint.project.reload
      end
      Note.create_event(sprint.project, 'task_created', 'Task Created: ' + task.description)
    else
      task.errors.full_messages.map {|e| errors << 'Error Creating task: ' + e}
    end
    task
  end

  private

  attr_reader :task
end
