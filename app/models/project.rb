# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: 'user_id', inverse_of: 'owner_projects', required: true
  has_many :project_customers
  has_many :customers, through: :project_customers, source: :user
  has_many :notes

  belongs_to :current_task, class_name: 'Task', foreign_key: 'task_id', inverse_of: 'project', optional: true

  has_many :sprints, -> {order 'sprint'}
  has_many :tasks
  has_many :tasks, through: :sprints, source: :tasks
  has_many :payments, through: :sprints
  has_many :invitations

  mount_uploader :image, AvatarUploader

  accepts_nested_attributes_for :customers
  accepts_nested_attributes_for :owner
  accepts_nested_attributes_for :sprints
  accepts_nested_attributes_for :current_task
  accepts_nested_attributes_for :tasks
  accepts_nested_attributes_for :notes
  accepts_nested_attributes_for :invitations

  validates :sprint_total, presence: true
  validates :sprint_current, presence: true
  validates :name, presence: true
  validates :github_url, presence: true, uniqueness: true

  # Create an Event
  def create_event(event_type, message)
    Note.create_event(self, event_type, message)
  end

  def sprint_events
    current_sprint.notes.where(note_type: [:event]).order('created_at DESC').all
  end

  def events
    sprint_events
  end

  def home_page_notes
    sprint_notes
  end

  def sprint_notes
    default_notes = current_sprint.notes.where(note_type: %i[note commit project_update payment payment_request demo]).order('created_at DESC').all
    if default_notes.empty?
      default_notes = current_sprint.notes.order('created_at DESC').all
    end
    default_notes
  end

  def owner?(user)
    owner == user
  end

  def customer?(user)
    if user.instance_of? String
      user = User.get_account user
      if user
        customers.include?(user)
      else
        return false
      end
    else
      customers.include?(user)
    end
  end

  def balance
    if !total_cost.nil? && !total_payment.nil?
      total_payment - total_cost
    else
      0
    end
  end

  def total_hours
    total = 0.0
    sprints.includes(:tasks).pluck(:hours).each do |hours|
      total += hours unless hours.nil?
    end
    total
  end

  def sprint_hours
    total_hours
  end

  def average_sprint_hours(precision = 2)
    return 0 if sprints.empty? || sprints.count.zero? || sprints.nil?
    sum = 0.0
    sprints.pluck(:hours).each do |sprint|
      sum += sprint.hours
    end
    (sum / sprints.count).round(precision, :banker)
  end

  def task_hours
    if tasks.empty? || tasks.sum(:hours).nil?
      0
    else
      tasks.sum(:hours)
    end
  end

  def average_task_hours(precision = 2)
    if tasks.empty? || tasks.average(:hours).nil?
      0
    else
      tasks.average(:hours).round(precision, :banker)
    end
  end

  def average_task_planned_hours(precision = 2)
    if tasks.empty? || tasks.average(:planned_hours).nil?
      0
    else
      tasks.average(:planned_hours).round(precision, :banker)
    end
  end

  def average_payment(precision = 2)
    if payments.empty? || ayments.average(:amount).nil?
      0
    else
      payments.average(:amount).round(precision, :banker)
    end
  end

  def total_cost
    total = 0.0
    sprints.each do |sprint|
      total += sprint.cost
    end
    total
  end

  def total_payment
    total = 0.0
    sprints.each do |sprint|
      sprint.payments.pluck(:amount).each do |payment|
        total += payment.amount
      end
    end
    total
  end

  def total_planned_hours
    total = 0.0
    sprints.each do |sprint|
      total += sprint.planned_hours
    end
    total
  end

  def total_planned_cost
    total = 0.0
    sprints.includes(:tasks).each do |sprint|
      total += sprint.planned_cost
    end
    total
  end

  def get_sprint(number)
    sprints.where(sprint: number).first
  end

  def current_sprint=(sprint)
    sprint_current = sprint.sprint

    unless sprint.open?
      sprint.open = true
      sprint.save
      sprint.reload
    end

    if sprint.invalid?
      logger.error('Error opening Sprint, while setting current sprint (changing sprint) on project ID: ' + id.to_s)
    end

    if invalid?
      logger.error('Error changing current sprint on project ID: ' + id.to_s)
    end

    save
  end

  def current_sprint
    get_sprint(sprint_current)
  end

  def payment_requests
    sprints.where(payment_due: true)
  end

  def payment_requested?
    sprints.each do |x|
      true if x.payment_due
    end
    false
  end

  def create_note(note_type, note_content)
    note = Note.new
    note.note_type = note_type
    note.content = note_content
    note.user_id = current_user
    note.project = self
    note.save
  end

  def non_customers
    nc = []
    User.all do |u|
      nc << u unless customer?(current_user)
    end
    nc
  end

  def max_planned_hours
    max = 0.00
    sprints.each do |i|
      max = i.planned_hours if max < i.planned_hours
    end
    max
  end

  def max_hours
    max = 0.00
    sprints.each do |i|
      max = i.hours if max < i.hours
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
