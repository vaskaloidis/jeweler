class Sprint < ApplicationRecord
  default_scope { order('sprint ASC') }
  belongs_to :project
  has_many :tasks, dependent: :destroy
  has_many :payments, dependent: :nullify
  has_many :notes, -> { order 'created_at DESC' }, dependent: :destroy
  accepts_nested_attributes_for :project
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

  def current_task
    project.current_task
  end

  # TODO: Replace with Scope possibly?
  def incomplete_tasks
    tasks.where(complete: false, deleted: false).all
  end
  def completed_tasks
    tasks.where(complete: true, deleted: false).all
  end
  def commits
    notes.where(note_type: :commit).sort_by(&:created_at)
  end

  # TODO: Refactor to just, current?
  def current?
    project.current_sprint == self
  end

  def balance
    sprint_payments - cost
  end

  def sprint_complete?
    return false if tasks.empty?
    tasks.each do |task|
      return false unless task.complete?
    end
    true
  end

  def total_payments
    sprint_payments
  end

  def sprint_payments
    payments.sum(:amount)
  end

  def cost
    total_cost = 0.00
    tasks.each do |item|
      next if item.hours.nil?
      total_cost += item.rate * item.hours
    end
    total_cost
  end

  def planned_cost
    total = 0.00
    tasks.each do |task|
      next if task.planned_hours.nil?
      total += task.planned_hours * task.rate
    end
    total
  end

  def hours
    tasks.where(deleted: false).sum(:hours)
  end

  def planned_hours
    tasks.where(deleted: false).sum(:planned_hours)
  end

  def average_hours
    tasks = tasks.where(deleted: false)
    0 if tasks.empty? or tasks.count.zero?
    sum = 0.0
    tasks.each do |task|
      sum += task.hours
    end
    sum / tasks.count
  end

  def only_planned?
    tasks.each do |task|
      false if !task.hours.nil? and task.hours != 0
    end
    true
  end

end
