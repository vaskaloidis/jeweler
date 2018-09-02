class Task::Create < Trailblazer::Operation
  step Model( Task, :new )
  step :setup
  failure :failure!, fail_fast: true
  step :choose_current_task!
  failure :set_current_task_failure
  step :create_note!

  def authorize!(options, current_user:, **)
    current_user
  end

  def setup!(options, params:, current_user:, **)
    options['model'] = Note.new(params[:task])
    options['model'].user = current_user
    options['model'].save!
  end

  def validate!(options, **)
    options['model'].valid?
  end

  def failure!(options, model:, **)
    options['result.errors'] = model.errors.full_messages
  end

  def choose_current_task(options, model:, **)
    sprint = Sprint.find(model['sprint_id'])
    project = sprint.project
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