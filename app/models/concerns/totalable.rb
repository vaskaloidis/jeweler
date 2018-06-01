# Adds methods to get total payments, cost, hours, planned-cost and planned-hours
#  of the tasks below. Available for Projects (all tasks) and Sprints (sprint tasks).
module Totalable
  extend ActiveSupport::Concern

  def balance
    if !total_cost.nil? && !total_payment.nil?
      total_payment - total_cost
    else
      0
    end
  end

  def total_cost
    total = 0.0
    tasks.each do |sprint|
      total += sprint.cost
    end
    total
  end

  def total_payment
    total = 0.0
    payments.pluck(:amount).each do |payment|
      total += payment.amount
    end
    total
  end

  def total_planned_hours
    total = 0.0
    tasks.each do |sprint|
      total += sprint.planned_hours
    end
    total
  end

  def total_planned_cost
    total = 0.0
    tasks.each do |sprint|
      total += sprint.planned_cost
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