class Event < ApplicationRecord

  belongs_to :eventable, polymorphic: true

  belongs_to :user, class_name: 'User', inverse_of: 'events', required: true
  belongs_to :sprint, required: true
  has_one :project, through: :sprint

  enum action: %i[task_created task_updated task_deleted sprint_opened
  sprint_closed planned_hours_reported owner_note developer_note customer_note
  project_update_note push payment_made task_completed sprint_completed
  current_task_changed current_sprint_changed payment_requested payment_request_cancelled
  invitation_accepted invitation_declined invitation_sent invitation_deleted hours_reported]

  default_scope {order('created_at DESC')}

  scope :timeline, -> {where(eventable_type: %i[note commit project payment sprint task])}
  # scope :events, -> {where(eventable_type: :event)}
  # scope :commits, -> {where(eventable_type: :commit)}
  # scope :payment, -> {where(eventable_type: :paymnt)}
  belongs_to :note, as: :note_event, polymorphic: true
  belongs_to :commit, as: :commit_event, polymorphic: true
  belongs_to :payment, as: :payment_event, polymorphic: true
  belongs_to :task, as: :task_event, polymorphic: true
  belongs_to :sprint, as: :sprint_event, polymorphic: true
  belongs_to :user, as: :user_event, polymorphic: true

  mount_uploader :image, AvatarUploader

  # before_validation :set_sprint
  # before_validation :set_content

  accepts_nested_attributes_for :sprint

  # validate :validate_subject_type
  # validates :content, presence: true

  def self.create_event(user, project, target, action, sprint)
    Event.create(user_id: user.id,
                 project_id: project.id,
                 sprint_id: sprint.id,
                 eventable: target,
                 subject: action)
  end

  # TODO: Finish developing the event description
  def set_content_old

    if self.details.nil?

      Event::DetailsFactory.new(self)

      subj = subject.to_sym
      self.details =
          case eventable
          when Invitation
            "#{eventable.email} was sent an invitation to join the project as a #{eventable.user_type}" if subj == invitation_sent?
          when Payment
            "$ #{eventable.payment_amount} payment for Sprint #{eventable.sprint.sprint} by #{eventable.user.full_name}" if self.payment_made?
          when Sprint
            "Sprint #{eventable.sprint.sprint} payment requested" if subj
          when Task
          when Commit
          when Note
          end

    end

  end

  def set_sprint
    if !eventable.nil? && sprint.nil?
      logger.info(eventable.inspect)
      self.sprint =
          case eventable
          when Project
            eventable.current_sprint
          when Sprint, Payment, Invitation, Task, Commit
            eventable.project.current_sprint
          else
            nil
          end
    end
  end

  def validate_subject_type
    et = EventType.new
    type = eventable_type.upcase.to_sym
    if et.class.const_defined? type
      unless et.class.const_get subject.upcase.to_sym
        errors.add(:eventable_type, 'invalid event subject.')
      end
    else
      errors.add(:eventable_type, 'must be a message, project, commit, payment, sprint or task ONLY.')
    end
  end

  def self.create_event_old(project, event_type, message, sprint = nil)
    note = Note.new
    note.note_type = 'event'
    note.author = User.current_user
    note.event_type = event_type

    note.project = project unless project.nil?

    if sprint.nil?
      note.sprint = project.current_sprint unless project.current_sprint.nil?
      note.task = project.current_task unless project.current_task.nil?
    else
      note.sprint = sprint
      note.task = sprint.project.current_task if project.current_sprint = sprint
    end

    # note.content = 'Sprint ' + note.sprint.sprint.to_s + ' - ' + message
    note.content = message

    note.save

    logger.error('Error saving project update') if note.invalid?

    note
  rescue StandardError => error
    logger.error(error)
  end

  def self.create_project_update(project, current_user, message)
    note = Note.new
    note.note_type = 'project_update'
    note.author = current_user

    note.project = project unless project.nil?

    note.sprint = project.current_sprint unless project.current_sprint.nil?

    note.task = project.current_task unless project.current_task.nil?

    # note.content = 'Sprint ' + note.sprint.sprint.to_s + ' - ' + message
    note.content = message

    note.save

    logger.error('Error saving project update') if note.invalid?

    note
  end

  def self.create_note_old(project, current_user, message)
    note = Note.new
    note.note_type = 'note'
    note.author = current_user

    note.project = project unless project.nil?

    note.sprint = project.current_sprint unless project.current_sprint.nil?

    note.task = project.current_task unless project.current_task.nil?

    note.content = message

    note.save

    logger.error('Error saving note') if note.invalid?

    note
  end
end
