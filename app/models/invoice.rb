class Invoice < ApplicationRecord
  belongs_to :project
  has_many :invoice_items
  has_many :payments

  has_many :notes

  accepts_nested_attributes_for :project
  accepts_nested_attributes_for :notes

  validates :sprint, presence: true

  def closed?
    if self.open
      return false
    else
      return true
    end
  end

  def open?
    if self.open
      return true
    else
      return false
    end
  end

  def max_position_int
    max_pos = self.invoice_items.maximum(:position)
    logger.debug("Max position: " + max_pos.to_s)
    return max_pos
  end

  def next_position_int
    if self.max_position_int.nil?
      return 0
    else
      return self.max_position_int + 1
    end
  end

  def current_letter
    return self.max_letter
  end

  def max_letter
    return ApplicationHelper.alphabet.at(self.max_position_int)
  end

  def next_letter
    return ApplicationHelper.alphabet.at(self.next_position_int)
  end

  def planned_hours
    return self.sprint_planned_hours
  end

  def current_task
    return self.project.current_task
  end

  def incomplete_tasks
    return self.invoice_items.where(complete: false, deleted: false).all
  end

  def completed_tasks
    return self.invoice_items.where(complete: true, deleted: false).all
  end

  def tasks
    return self.invoice_items.where(deleted: false).all.sort_by(&:created_at)
  end

  def commits
    return self.notes.where(note_type: :commit).sort_by(&:created_at)
  end

  def is_current?
    if self.project.current_sprint == self
      return true
    else
      return false
    end
  end

  def balance
    return (self.sprint_cost - self.sprint_payments)
  end

  def sprint_complete?
    if self.tasks.empty?
      return false
    end
    self.tasks.each do |invoice|
      if !invoice.complete?
        return false
      end
    end
    return true
  end

  def total_payments
    return self.sprint_payments
  end

  def sprint_payments
    return self.payments.sum(:amount)
  end

  def cost
    return self.sprint_cost
  end

  def sprint_cost
    total_cost = 0.00
    self.tasks.each do |item|
      unless item.hours.nil?
        total_cost = total_cost + (item.rate * item.hours)
      end
    end
    return total_cost
  end

  def sprint_planned_cost
    total = 0.00
    self.tasks.each do |item|
      unless item.planned_hours.nil?
        total = total + (item.planned_hours * item.rate)
      end
    end
    return total
  end

  def sprint_hours
    return self.invoice_items.where(deleted: false).sum(:hours)
  end

  def hours
    return self.sprint_hours
  end

  def sprint_planned_hours
    return self.invoice_items.where(deleted: false).sum(:planned_hours)
  end

  def only_planned?
    self.tasks.each do |task|
      if !task.hours.nil? and task.hours != 0
        return false
      end
    end
    return true
  end

end
