# frozen_string_literal: true

# Creates a Task from the supplied params, then
#  sets that task as Current-Task if appropriate.
class CreateTask < Jeweler::ServiceObject
  def initialize(task_params)
    @task = Task.new(task_params)
  end

  def call
    task.position = task.sprint.next_position_int
    if task.save
      sprint = Sprint.find(task.sprint.id)
      # Set Current task if no other tasks, and is first Sprint task created,
      #  and is it's Sprint current?
      if task.sprint.tasks.empty? && task.sprint.project.current_task.nil? && task.sprint.current?
        project = task.sprint.project
        project.current_task = task
        project.save
        if project.invalid?
          errors << 'Error while setting this as the current-task'
          project.errors.full_messages.log_errors('CreateTask S.O. - Error setting current-task after create')
        end
        task.sprint.project.reload
      end
      Note.create_event(sprint.project, 'task_created', 'Task Created: ' + task.description)
    else
      Rails.logger.error('CreateTaskSO: Task was not saved correctly')
      task.errors.full_messages.map {|e| errors << 'Error Creating task: ' + e}
    end
    task
  end

  private

  attr_reader :task
end
