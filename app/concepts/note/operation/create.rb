class Note::Create < Trailblazer::Operation
  step :create
  failure :failure!, fail_fast: true
  step :identify_sprint
  step :choose_current_task!
  failure :set_current_task_failure
  step :create_note!

  def create(options, params, current_user:)
    task = Note.new(params)
    task.user = current_user
    task.save!
    options['model'] = task
  end

  def failure!(options)
    options["result.model"] = "Could not create new task."
  end

  def identify_sprint(options, *)
    sprint = options['result.model.sprint']
    options['result.sprint'] = Sprint.find(sprint.id)
  end

  def choose_current_task(options, *)
    sprint = options['result.sprint']
    if sprint.tasks.empty? && sprint.project.current_task.nil? && task.sprint.current?
      project = task.sprint.project
      project.current_task = task
      project.save
      if project.invalid?
        Rails.logger.error('CreateTask S.O. - Error setting current-task after create')
      end
    end
  end

end