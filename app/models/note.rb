class Note < ApplicationRecord
  enum note_type: [:note, :project_update, :demo, :commit, :payment, :payment_request, :task, :event]

  enum event_type: [:task_created, :task_updated, :task_deleted, :sprint_opened, :sprint_closed, :hours_reported, :task_completed, :sprint_completed, :current_task_changed, :current_sprint_changed, :payment_request_cancelled, :invitation_accepted, :invitation_declined, :invitation_sent, :invitation_deleted]

  belongs_to :project
  has_many :discussions, dependent: :destroy
  belongs_to :author, :class_name => 'User', :foreign_key => 'user_id', inverse_of: 'notes', required: true

  belongs_to :sprint, optional: true
  belongs_to :task, optional: true

  mount_uploader :image, AvatarUploader

  accepts_nested_attributes_for :sprint
  accepts_nested_attributes_for :task

  def self.note_types
    note_types = []
    note_types << 'all'
    note_types << 'note'
    note_types << 'project_update'
    note_types << 'demo'
    note_types << 'commit'
    note_types << 'payment'
    note_types << 'payment_request'
    note_types << 'event'
    note_types
  end

  def self.create_payment(sprint, current_user, payment_amount)
    project = sprint.project

    note = Note.new
    note.note_type = 'payment'
    note.author = current_user
    note.project = project

    unless project.current_sprint.nil?
      note.sprint = project.current_sprint
    end

    unless project.current_task.nil?
      note.task = project.current_task
    end

    note.content = '$' + payment_amount.to_s + ' Payment for Sprint ' + sprint.sprint.to_s
    note.save

    if note.invalid?
      logger.error("Error saving project update")
    end

    return note
  end

  def self.create_payment_request(sprint, current_user)
    project = sprint.project

    note = Note.new
    note.note_type = 'payment_request'
    note.author = current_user
    note.project = project

    unless project.current_sprint.nil?
      note.sprint = project.current_sprint
    end

    unless project.current_task.nil?
      note.task = project.current_task
    end

    note.content = 'Sprint ' + sprint.sprint.to_s + ' Payment Requested'
    note.save

    if note.invalid?
      logger.error("Error saving project update")
    end

    return note
  end

  def self.create_event(project, event_type, message, sprint = nil)
    begin
      note = Note.new
      note.note_type = 'event'
      note.author = User.current_user
      note.event_type = event_type

      unless project.nil?
        note.project = project
      end

      if sprint.nil?
        unless project.current_sprint.nil?
          note.sprint = project.current_sprint
        end
        unless project.current_task.nil?
          note.task = project.current_task
        end
      else
        note.sprint = sprint
        if project.current_sprint = sprint
          note.task = sprint.current_task
        end
      end

      # note.content = 'Sprint ' + note.sprint.sprint.to_s + ' - ' + message
      note.content = message

      note.save

      if note.invalid?
        logger.error("Error saving project update")
      end

      return note

    rescue => error
      logger.error(error)
    end

  end

  def self.create_project_update(project, current_user, message)

    note = Note.new
    note.note_type = 'project_update'
    note.author = current_user

    unless project.nil?
      note.project = project
    end

    unless project.current_sprint.nil?
      note.sprint = project.current_sprint
    end

    unless project.current_task.nil?
      note.task = project.current_task
    end

    # note.content = 'Sprint ' + note.sprint.sprint.to_s + ' - ' + message
    note.content = message

    note.save

    if note.invalid?
      logger.error("Error saving project update")
    end

    return note
  end

  def self.create_note(project, current_user, message)

    note = Note.new
    note.note_type = 'note'
    note.author = current_user

    unless project.nil?
      note.project = project
    end

    unless project.current_sprint.nil?
      note.sprint = project.current_sprint
    end

    unless project.current_task.nil?
      note.task = project.current_task
    end

    note.content = message

    note.save

    if note.invalid?
      logger.error("Error saving note")
    end

    return note
  end


end
