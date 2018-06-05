# Adds methods to get total payments, cost, hours, planned-cost and planned-hours
#  of the tasks below. Available for Projects (all tasks) and Sprints (sprint tasks).
module Totalable
  extend ActiveSupport::Concern

  def balance
    if !cost.nil? && !payment.nil?
      payment - cost
    else
      0
    end
  end

  def cost
    total = 0.0
    tasks.each do |task|
      total += task.cost
    end
    total
  end

  def payment
    total = 0.0
    payments.pluck(:amount).each do |payment|
      total += payment.amount
    end
    total
  end

  def planned_hours
    total = 0.0
    tasks.each do |task|
      total += task.planned_hours
    end
    total
  end

  def planned_cost
    total = 0.0
    tasks.each do |task|
      total += task.planned_cost
    end
    total
  end

  def hours
    if tasks.empty? || tasks.sum(:hours).nil?
      0
    else
      tasks.sum(:hours)
    end
  end

end