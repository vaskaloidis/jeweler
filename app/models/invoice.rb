class Invoice < ApplicationRecord
  belongs_to :project
  has_many :invoice_items
  has_many :payments

  accepts_nested_attributes_for :project

  def sprint_payments
    total_payments = 0
    self.payments.each do |p|
      total_payments = total_payments + p.amount
    end
    return total_payments
  end

  def sprint_cost
    total_cost = 0
    self.invoice_items.each do |item|
      total_cost = total_cost + (item.rate * item.hours)
    end
    return total_cost
  end

  def sprint_planned_cost
    total = 0
    self.invoice_items.each do |item|
      total = total + (item.planned_hours * item.rate)
    end
    return total
  end

  def sprint_hours
    total_cost = 0
    self.invoice_items.each do |item|
      total_cost = total_cost + item.hours
    end
    return total_cost
  end

  def sprint_planned_hours
    total = 0
    self.invoice_items.each do |item|
      total = total + item.planned_hours
    end
    return total
  end

end
