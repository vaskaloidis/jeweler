class InvoiceItem < ApplicationRecord
  belongs_to :invoice

  #   has_many :owner_projects, class_name: 'Project', inverse_of: 'owner'
  has_one :project, class_name: 'Project', inverse_of: 'current_task', dependent: :nullify
  has_many :notes, dependent: :nullify

  accepts_nested_attributes_for :notes
  accepts_nested_attributes_for :invoice
  accepts_nested_attributes_for :project


  validates :planned_hours, numericality: { message: 'Must be a number.' }, allow_nil: true
  validates :hours, numericality: { message: 'Must be a number.' }, allow_nil: true
  validates :description, presence: { message: 'Cannot be empty.' }
  validates :rate, presence: {message: 'must cannot me empty.'}, numericality: { message: 'must be a number.' }

  def set_next_position
    self.position = self.invoice.next_position_int
  end
  def task_id
    return 'task' + self.invoice.sprint.to_s + self.get_letter
  end
  def get_letter
    return ApplicationHelper.alphabet.at(self.position)
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

  def total_cost
    if self.hours.nil?
      return 0.00
    else
      return self.rate * self.hours
    end
  end

  def planned_cost
    if self.planned_hours.nil?
      return 0.00
    else
      return self.rate * self.planned_hours
    end
  end

  def is_current?
    task = self.invoice.project.current_task
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
