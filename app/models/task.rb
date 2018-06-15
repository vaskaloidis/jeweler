class Task < ApplicationRecord
  after_create :set_position
  belongs_to :sprint, required: true
  has_one :project, class_name: 'Project', inverse_of: 'current_task', dependent: :nullify
  has_many :notes, dependent: :nullify

  default_scope {where(deleted: false)}
  scope :incomplete_tasks, -> {where(complete: false, deleted: false)}
  scope :completed_tasks, -> {where(complete: true, deleted: false)}

  accepts_nested_attributes_for :notes
  accepts_nested_attributes_for :sprint
  accepts_nested_attributes_for :project

  validates :planned_hours, numericality: {message: 'Must be a number.'}, allow_nil: true
  validates :hours, numericality: {message: 'Must be a number.'}, allow_nil: true
  validates :description, presence: {message: 'Cannot be empty.'}
  validates :rate, presence: {message: 'must cannot me empty.'}, numericality: {message: 'must be a number.'}

  def set_position
    self.position = sprint.next_position_int
    save
  end

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

end
