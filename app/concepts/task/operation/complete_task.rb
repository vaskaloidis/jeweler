# frozen_string_literal: true

# Complete a specified task. If the task is specified as current,
#  then set the next qualified task as current
class CompleteTask < Jeweler::Service
  def initialize(task)
    @task = task
  end

  def call
    task.sprint.project.create_event('task_completed', 'Complete: ' + task.description)

    task.complete = true
    task.save
    task.reload

    ChooseNextCurrentTask.call(task)

    sprint = task.sprint
    if sprint.complete?
      # Do We Want To Close Sprint Upon Completion Feature? No, we make it a setting
      close_sprint_upon_completion_feature = false
      if close_sprint_upon_completion_feature
        if sprint.open
          sprint.open = false
          sprint.save
        end
      end
    end
    task
  end

  private

  attr_reader :task
end
