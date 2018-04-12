class Invoice < ApplicationRecord
  belongs_to :project
  has_many :invoice_items
  has_many :payments

  has_many :notes

  accepts_nested_attributes_for :project
  accepts_nested_attributes_for :notes


  validates :sprint, presence: true

  def sprint_complete?
    if self.invoice_items.empty?
      return false
    end
    self.invoice_items.each do |invoice|
      if !invoice.complete?
        return false
      end
    end
    return true
  end

  def sprint_payments
    total_payments = 0
    self.payments.each do |p|
      total_payments = total_payments + p.amount
    end
    return ApplicationHelper.prettify(total_payments)
  end

  def sprint_cost
    total_cost = 0
    self.invoice_items.each do |item|
      unless item.hours.nil?
        total_cost = total_cost + (item.rate * item.hours)
      end
    end
    return ApplicationHelper.prettify(total_cost)
  end

  def sprint_planned_cost
    total = 0
    self.invoice_items.each do |item|
      unless item.planned_hours.nil?
        total = total + (item.planned_hours * item.rate)
      end
    end
    return ApplicationHelper.prettify(total)
  end

  def sprint_hours
    total_cost = 0
    self.invoice_items.each do |item|
      unless item.hours.nil?
        total_cost = total_cost + item.hours
      end
    end
    return ApplicationHelper.prettify(total_cost)
  end

  def sprint_planned_hours
    total = 0
    self.invoice_items.each do |item|
      unless item.planned_hours.nil?
        total = total + item.planned_hours
      end
    end
    return ApplicationHelper.prettify(total)
  end

  def only_planned?
    self.invoice_items.each do |task|
      if !task.hours.nil? and task.hours != 0
        return false
      end
    end
    return true
  end

end
