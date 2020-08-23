# frozen_string_literal: true

# Creates a Task from the supplied params, then
#  sets that task as Current-Task if appropriate.

class CreateTask < Jeweler::Service
	include EventHelper

	def initialize(task_params)
		@task = Task.new(task_params)
	end

	def call
		task.save
		if task.valid?
			@result_message = 'Task created Succesfully'
			set_current_task
			create_event(current_user.id, @task, :task_created, @sprint.id)
		else
			task.errors.full_messages.map { |e| errors << 'Error Creating task: ' + e }
		end
		task
	end

	private

	attr_reader :task


	# Set Current task if no other tasks, and is first Sprint task created,
	#  and is it's Sprint current?
	def set_current_task
		if task.sprint.tasks.empty? && task.sprint.project.current_task.nil? && task.sprint.current?
			project              = task.sprint.project
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
