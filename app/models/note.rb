class Note < ApplicationRecord
  enum note_type: [:note, :project_update, :demo, :commit, :payment, :payment_request, :task, :event]

  enum event_type: [:task_created, :task_updated, :task_deleted, :sprint_opened, :sprint_closed, :hours_reported, :task_completed, :sprint_completed, :current_task_changed, :current_sprint_changed, :payment_request_cancelled, :invitation_accepted, :invitation_declined, :invitation_sent, :invitation_deleted]

  belongs_to :project
  has_many :discussions, dependent: :destroy
  belongs_to :author, :class_name => 'User', :foreign_key => 'user_id', inverse_of: 'notes', required: true

  belongs_to :invoice, optional: true
  belongs_to :invoice_item, optional: true

  mount_uploader :image, AvatarUploader

  accepts_nested_attributes_for :invoice
  accepts_nested_attributes_for :invoice_item

  def self.note_types
    note_types = Array.new
    note_types << 'all'
    note_types << 'note'
    note_types << 'project_update'
    note_types << 'demo'
    note_types << 'commit'
    note_types << 'payment'
    note_types << 'payment_request'
    note_types << 'event'
    return note_types
  end

  def self.create_payment(invoice, current_user, payment_amount)
    project = invoice.project

    note = Note.new
    note.note_type = 'payment'
    note.author = current_user
    note.project = project

    unless project.current_sprint.nil?
      note.invoice = project.current_sprint
    end

    unless project.current_task.nil?
      note.invoice_item = project.current_task
    end

    note.content = '$' + payment_amount.to_s + ' Payment for Sprint ' + invoice.sprint.to_s
    note.save

    if note.invalid?
      logger.error("Error saving project update")
    end

    return note
  end

  def self.create_payment_request(invoice, current_user)
    project = invoice.project

    note = Note.new
    note.note_type = 'payment_request'
    note.author = current_user
    note.project = project

    unless project.current_sprint.nil?
      note.invoice = project.current_sprint
    end

    unless project.current_task.nil?
      note.invoice_item = project.current_task
    end

    note.content = 'Sprint ' + invoice.sprint.to_s + ' Payment Requested'
    note.save

    if note.invalid?
      logger.error("Error saving project update")
    end

    return note
  end

  def self.create_event(project, event_type, message, invoice = nil)
    begin
      note = Note.new
      note.note_type = 'event'
      note.author = User.current_user
      note.event_type = event_type

      unless project.nil?
        note.project = project
      end

      if invoice.nil?
        unless project.current_sprint.nil?
          note.invoice = project.current_sprint
        end
        unless project.current_task.nil?
          note.invoice_item = project.current_task
        end
      else
        note.invoice = invoice
        if project.current_sprint = invoice
          note.invoice_item = invoice.current_task
        end
      end

      # note.content = 'Sprint ' + note.invoice.sprint.to_s + ' - ' + message
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
      note.invoice = project.current_sprint
    end

    unless project.current_task.nil?
      note.invoice_item = project.current_task
    end

    # note.content = 'Sprint ' + note.invoice.sprint.to_s + ' - ' + message
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
      note.invoice = project.current_sprint
    end

    unless project.current_task.nil?
      note.invoice_item = project.current_task
    end

    note.content = message

    note.save

    if note.invalid?
      logger.error("Error saving note")
    end

    return note
  end


end
