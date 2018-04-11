class InvoiceItem < ApplicationRecord
  belongs_to :invoice

  #   has_many :owner_projects, class_name: 'Project', inverse_of: 'owner'
  has_one :project, class_name: 'Project', inverse_of: 'current_task', dependent: :nullify
  has_many :notes, dependent: :nullify

  accepts_nested_attributes_for :notes
  accepts_nested_attributes_for :invoice

  # validates :planned_hours, presence: true
  # validates :description, presence: true
  # validates :rate, presence: true


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
      return 0.0
    else
      return ApplicationHelper.prettify(self.rate * self.hours)
    end
  end

  def planned_cost
    if self.planned_hours.nil?
      return 0.0
    else
      return ApplicationHelper.prettify(self.rate * self.planned_hours)
    end
  end

  def is_current?
    if self.invoice.project.current_task == self
      return true
    else
      return false
    end
  end

end
