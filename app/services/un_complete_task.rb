# frozen_string_literal: true

# Set a specified task as not complete
class UnCompleteTask < Jeweler::ServiceObject
  def initialize(task)
    @task = task
  end

  def call
    task.complete = false
    task.save
    task.reload
    task
  end

  private

  attr_reader :task
end