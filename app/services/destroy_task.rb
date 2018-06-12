# frozen_string_literal: true

# Delete a task by setting the task deleted attribute to true
# Then create the event
class DestroyTask < Jeweler::ServiceObject
  def initialize(task)
    @task = task
  end

  def call
    if task.update(deleted: true)
      Note.create_event(task.sprint.project, 'task_deleted', 'Deleted: ' + task.description)
    else
      task.errors.full_messages.map { |e| fatals << 'Error Destroying Task: ' + e }
    end
    task
  end

  private

  attr_reader :task
end
