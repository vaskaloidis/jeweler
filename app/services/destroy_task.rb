# frozen_string_literal: true

class DestroyTask < Jeweler::ServiceObject
  def initialize(task)
    @task = task
  end

  def call
    Note.create_event(task.sprint.project, 'task_deleted', 'Deleted: ' + task.description)
    task.deleted = true
    task.save
    task.reload

    if task.invalid?
      task.errors.full_messages.map { |e| @errors << 'Error Destroying Invoice: ' + e }
    end

    task
  end

  private

  attr_reader :task
end
