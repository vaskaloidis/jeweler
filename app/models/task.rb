class Task < ApplicationRecord
  belongs_to :sprint, required: true

  has_one :project, class_name: 'Project', inverse_of: 'current_task', dependent: :nullify
  has_many :notes, dependent: :nullify

  default_scope { where(deleted: false) }
  scope :incomplete_tasks, -> {where(complete: false, deleted: false)}
  scope :completed_tasks, -> {where(complete: true, deleted: false)}

  accepts_nested_attributes_for :notes
  accepts_nested_attributes_for :sprint
  accepts_nested_attributes_for :project

  validates :planned_hours, numericality: { message: 'Must be a number.' }, allow_nil: true
  validates :hours, numericality: { message: 'Must be a number.' }, allow_nil: true
  validates :description, presence: { message: 'Cannot be empty.' }
  validates :rate, presence: {message: 'must cannot me empty.'}, numericality: { message: 'must be a number.' }

  def task_id
    raise StandardError.new('Sprint.sprint is nil') if sprint.nil? or sprint.sprint.nil? or letter.nil?
    result = '#task' + sprint.sprint.to_s + letter.to_s
    Rails.logger.info 'Task_ID: ' + result.to_s
    return result
  end

  def letter
    ApplicationHelper.alphabet.at(position)
  end

  # def hours
  #   h = self.hours
  #   return ApplicationHelper.prettify(h)
  # end
  #
  # def planned_hours
  #   ph = self.planned_hours
  #   return ApplicationHelper.prettify(ph)
  # end

  def cost
    if hours.nil?
      0.00
    else
      rate * hours
    end
  end

  def planned_cost
    if self.planned_hours.nil?
      return 0.00
    else
      return self.rate * self.planned_hours
    end
  end

  def current?
    task = self.sprint.project.current_task
    unless task.nil?
      if task == self
        return true
      else
        return false
      end
    else
      return false
    end
  end

end
