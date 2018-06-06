# frozen_string_literal: true

class SetCurrentTask < Jeweler::ServiceObject
  def initialize(task)
    @task = task
  end

  def call
    old_task = task.sprint.project.current_task
    if task.sprint != task.sprint.project.current_sprint
      errors << 'Current Task must be within Current Sprint.'
    else
      unless old_task.nil? || old_task.complete
        old_task.complete = true
        old_task.save
        old_task.reload
      end

      task.sprint.project.current_task = task
      task.sprint.project.save
      task.sprint.project.reload

      if task.complete? != false
        task.complete = false
        task.save
      end

      if task.sprint.closed?
        task.sprint.open = true
        task.sprint.save
      end
      task.reload
    end
    if task.sprint.project.valid?
      Note.create_event(task.sprint.project, 'current_task_changed', 'Current Task: ' + task.description)
    else
      errors << 'Error changing current task.'
    end

    task
  end

  private

  attr_reader :task
end
