# Projects and Sprints can get their tasks average hours, planned-hours and payments
#  Projects can get the average sprint hours (Exception thrown otherwise)
module Averageable
  extend ActiveSupport::Concern

  included do
  end

  def average_task_hours(precision = 2)
    if tasks.empty? || tasks.average(:hours).nil?
      0
    else
      tasks.average(:hours).round(precision)
    end
  end

  def average_task_planned_hours(precision = 2)
    if tasks.empty? || tasks.average(:planned_hours).nil?
      0
    else
      tasks.average(:planned_hours).round(precision)
    end
  end

  def average_payment(precision = 2)
    if payments.empty? || ayments.average(:amount).nil?
      0
    else
      payments.average(:amount).round(precision)
    end
  end

  def average_sprint_hours(precision = 2)
    if defined? sprints
      return 0 if sprints.empty? || sprints.count.zero? || sprints.nil?
      sum = 0.0
      sprints.each do |sprint|
        sum += sprint.hours
      end
      (sum / sprints.count).round(precision)
    else
      raise NoMethodError 'You can only get the average of sprints from a Project (it needs to have sprints)'
    end
  end

end