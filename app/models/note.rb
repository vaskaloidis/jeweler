class Note < ApplicationRecord
  enum note_type: [ :note, :project_update, :demo, :commit, :payment, :payment_request, :task, :event ]

  belongs_to :project
  has_many :discussions
  belongs_to :author, :class_name => 'User', :foreign_key => 'user_id', inverse_of: 'notes', required: true

  belongs_to :invoice, optional: true
  belongs_to :invoice_item, optional: true

  mount_uploader :image, AvatarUploader

  accepts_nested_attributes_for :invoice
  accepts_nested_attributes_for :invoice_item

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

    note.content = '$' + payment_amount + ' Payment for Sprint ' + invoice.sprint.to_s
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

  def self.create_event(project, current_user, message)

    note = Note.new
    note.note_type = 'event'
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
