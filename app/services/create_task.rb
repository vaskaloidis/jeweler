# frozen_string_literal: true

# Creates a Task from the supplied params, then
#  sets that task as Current-Task if appropriate.
class CreateTask < Jeweler::Service
  def initialize(task_params, current_user)
    @task = Task.new(task_params)
    @task.user = current_user
  end

  def call
    task.save
    if task.valid?
      @result_message = 'Task created Succesfully'
      set_current_task
      create_note
    else
      task.errors.full_messages.map {|e| errors << 'Error Creating task: ' + e}
    end
    task
  end

  private
  attr_reader :task

  def create_note
    sprint = Sprint.find(task.sprint.id)
    Note.create_event(sprint.project, 'task_created', 'Task Created: ' + task.description)
  end

  # Set Current task if no other tasks, and is first Sprint task created,
  #  and is it's Sprint current?
  def set_current_task
    if task.sprint.tasks.empty? && task.sprint.project.current_task.nil? && task.sprint.current?
      project = task.sprint.project
      project.current_task = task
      project.save
      if project.invalid?
        errors << 'Error while setting this as the current-task'
        Rails.logger.fatal('CreateTask S.O. - Error setting select_next_task')
      end
      task.sprint.project.reload
    end
  end
end
