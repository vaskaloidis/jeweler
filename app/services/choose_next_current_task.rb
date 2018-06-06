# frozen_string_literal: true

class ChooseNextCurrentTask < Jeweler::ServiceObject
  def initialize(task)
    @task = task
  end

  def call
    if task.current?
      task.sprint.project.current_task = nil
      task.sprint.project.save
      @next_task = false
      until !task.sprint.project.current_task.nil? || task.sprint.incomplete_tasks.empty?
        task.sprint.tasks.each do |task|
          if @next_task
            if task.complete == false
              task.sprint.project.current_task = task
              task.sprint.project.save
              task.sprint.project.reload
              break
            end
          elsif task == task && !@next_task
            @next_task = true
          end
        end
      end
    end
  end

  private

  attr_reader :task
end
