# Get the max hours, planned-hours, and payment of each sprint or task
module Maxable
  extend ActiveSupport::Concern

  def max_planned_hours
    max = 0.00
    if defined? sprints
      sprints.each do |i|
        max = i.planned_hours if max < i.planned_hours
      end
    else
      tasks.each do |i|
        max = i.planned_hours if max < i.planned_hours
      end
    end
    max
  end

  def max_hours
    max = 0.00
    if defined? sprints
      sprints.each do |i|
        max = i.hours if max < i.hours
      end
    else
      tasks.each do |i|
        max = i.hours if max < i.hours
      end
    end
    max
  end

  def max_payment
    max = 0.00
    payments.each do |p|
      max = p.amount if p.amount > max
    end
    max
  end

end
