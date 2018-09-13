class Sprint < ApplicationRecord
  include Totalable
  include Averageable
  include Maxable

  default_scope {order('sprint ASC')}

  belongs_to :project
  has_many :tasks, dependent: :destroy
  has_many :payments, dependent: :nullify
  has_many :notes, dependent: :destroy

  accepts_nested_attributes_for :project
  accepts_nested_attributes_for :tasks
  accepts_nested_attributes_for :payments
  accepts_nested_attributes_for :notes

  # TODO: Add validation error for: if sprint_total <= sprint_current
  validates :sprint, presence: true

  def closed?
    false if open
  end

  def open?
    open
  end

  def max_position_int
    max_pos = tasks.maximum(:position)
    logger.debug('Max position: ' + max_pos.to_s)
    max_pos
  end

  def next_position_int
    if max_position_int.nil?
      0
    else
      max_position_int + 1
    end
  end

  def current_letter
    max_letter
  end

  def max_letter
    ApplicationHelper.alphabet.at(max_position_int)
  end

  def next_letter
    ApplicationHelper.alphabet.at(next_position_int)
  end

  def planned_hours
    tasks.where(deleted: false).sum(:planned_hours)
  end

  def current?
    project.current_sprint == self
  end

  def complete?
    return false if tasks.empty?
    tasks.each do |task|
      return false unless task.complete?
    end
    true
  end

  # Returns true if all Sprint Tasks have NOT yet reported Hours,
  # False if any Sprint Tasks have reported actual Hours
  def estimate?
    tasks.each do |task|
      return false if task.hours != 0
    end
    true
  end

end
