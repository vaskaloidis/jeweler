# frozen_string_literal: true

# Ajax Actions for Sprint Controller
module Sprint::Ajaxable
  extend ActiveSupport::Concern

  included do
    before_action :set_sprint, only: %i[edit_description render_panel
                                     set_current_task set_current_sprint
                                     open_sprint_inline close_sprint_inline show
                                     edit update destroy]
    respond_to :json, :html, only: %i[show edit update destroy]
    respond_to :js, only: %i[edit_description render_panel open_sprint_payment
                             open_payment show edit update destroy]
  end

  def edit_description; end

  def render_panel; end

  def set_current_task
    @task = Task.find(params[:task_id])
    @old_task = @task.sprint.project.current_task

    if @task.sprint != @task.sprint.project.current_sprint
      @error = true
      @error_message = 'Current Task must be within Current Sprint.'
      logger.debug('Error: ' + @error_message)
    else
      logger.debug('No Errors')
      @error = false
      unless @old_task.nil? || @old_task.complete
        @old_task.complete = true
        @old_task.save
        @old_task.reload
      end

      @task.sprint.project.current_task = @task
      @task.sprint.project.save
      @task.sprint.project.reload
      @task.sprint.reload

      if @task.complete? != false
        @task.complete = false
        @task.save
        @task.reload
      end

      if @task.sprint.closed?
        @task.sprint.open = true
        @task.sprint.save
      end

      @current_sprint = @task.sprint.project.sprint_current

    end
    if @task.sprint.project.valid?
      Note.create_event(@task.sprint.project, 'current_task_changed', 'Current Task: ' + @task.description)
    else
      @error = true
      @error_message = 'Error changing current task.'
      logger.error('Error Changing Current Task From to ID: ' + @task.id.to_s)
    end

    logger.debug('Setting Task ' + @task.id.to_s + ' for Invoice ' + @task.sprint.id.to_s)
  end

  def set_current_sprint

    logger.debug('Setting Current Sprint ' + @sprint.id.to_s)

    @old_sprint_id = @project.current_sprint
    @project.current_sprint = @sprint

    @project.current_task = nil unless @project.current_task.nil?
    @project.save
    @project.reload
    @sprint.reload
    @old_sprint.reload

    if @project.valid?
      Note.create_event(@project, 'current_sprint_changed', 'Current Sprint Changed From ' + @old_sprint.sprint.to_s + ' to ' + @sprint.sprint.to_s)
    else
      logger.error('Error Changing Current Sprint From ' + @old_sprint.sprint.to_s + ' to ' + @sprint.sprint.to_s)
    end

    @current_sprint = @project.sprint_current
  end

  def open_sprint_inline
    @sprint.open = true
    @sprint.save

    Note.create_event(@sprint.project, 'sprint_opened', 'Sprint ' + @sprint.sprint.to_s + ' Opened ')

    if @sprint.invalid?
      logger.error('Sprint ' + @sprint.sprint.to_s + ' could not be opened. ID: ' + @sprint.id.to_s)
      logger.error(@sprint.errors)
    end

    @sprint.reload
  end

  def close_sprint_inline
    @sprint.open = false
    @sprint.save

    Note.create_event(@sprint.project, 'sprint_closed', 'Sprint ' + @sprint.sprint.to_s + ' Closed ')

    if @sprint.invalid?
      logger.error('Sprint ' + @sprint.sprint.to_s + ' could not be closed. ID: ' + @sprint.id.to_s)
      logger.error(@sprint.errors)
    end

    @sprint.reload
  end

  private

  def set_sprint
    @sprint = Sprint.find(params[:id])
    @project = @sprint.project
  end
end
