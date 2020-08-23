module EventHelper

	# def create_note_old
	# 	sprint = Sprint.find(task.sprint.id)
	# 	Note.create_event(sprint.project, 'task_created', 'Task Created: ' + task.description)
	# end
	#
	# def create_note
	# 	sprint = Sprint.find(task.sprint.id)
	# 	Note.create_event(sprint.project, 'task_created', 'Task Created: ' + task.description)
	# end


	def create_event(user, target, action, sprint)
			Event.create(user_id: user.id,
			             eventable: target,
			             subject: action,
			             sprint_id: sprint.id,
			             project_id: sprint.project.id)
	end

end