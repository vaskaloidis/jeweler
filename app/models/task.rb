class Task < ApplicationRecord
  after_create :set_position
  belongs_to :sprint, required: true
  has_one :project, class_name: 'Project', inverse_of: 'current_task', dependent: :nullify
  has_many :events, as: :eventable, dependent: :nullify
  belongs_to :assigned_to, class_name: 'User', optional: true
  belongs_to :created_by, class_name: 'User'

  default_scope {where(deleted: false)}
  scope :incomplete_tasks, -> { where(complete: false, deleted: false) }
  scope :completed_tasks, -> { where(complete: true, deleted: false) }


  accepts_nested_attributes_for :events
  accepts_nested_attributes_for :sprint
  accepts_nested_attributes_for :project

  validates :planned_hours, numericality: {message: 'Must be a number.' }, allow_nil: true
  validates :hours, numericality: {message: 'Must be a number.' }, allow_nil: true
  validates :description, presence: {message: 'Cannot be empty.' }
  validates :rate, presence: {message: 'must cannot me empty.' }, numericality: {message: 'must be a number.' }
  validate :validate_created_by
  validate :validate_assigned_to

  def code
    raise StandardError.new('task.letter is nil') if letter.nil?
    result = '#task' + sprint.sprint.to_s + letter.to_s
    Rails.logger.info 'Task_ID: ' + result.to_s
    return result
  end

  def letter
    ApplicationHelper.alphabet.at(position)
  end

  def cost
    0.00 if hours.nil?
    rate * hours
  end

  def planned_cost
    0.00 if planned_hours.nil?
    rate * planned_hours
  end

  def current?
    current_task = sprint.project.current_task
    return false if current_task.nil?
    current_task == self
  end

  def validate_created_by
    project = sprint.project
    if created_by.nil?
      errors.add(:created_by, 'cannot be nil.')
    else
      unless created_by.id == project.owner.id || project.developers.include?(created_by)
        errors.add(:created_by, 'must be the Project Owner or a Developer.')
      end
    end
  end

  def validate_assigned_to
    project = sprint.project
    unless assigned_to.nil?
      unless assigned_to.id == project.owner.id || project.developers.include?(assigned_to)
        errors.add(:assigned_to, 'must be the Project Owner or a Developer.')
      end
    end
  end

  private

  def set_position
    self.position = sprint.next_position_int
    save
  end

end
