# frozen_string_literal: true

# The main Class for Jeweler, used for every Project
class Project < ApplicationRecord
  include Averageable
  include Totalable
  include Maxable

  after_save :build_sprints, if: ->(obj) { obj.sprint_total.present? || obj.sprint_total_changed? }

  belongs_to :current_task, class_name: 'Task', foreign_key: 'task_id', inverse_of: 'project', optional: true
  belongs_to :owner, class_name: 'User', foreign_key: 'user_id', inverse_of: 'owner_projects', required: true, dependent: :destroy

  has_many :project_customers, dependent: :destroy
  has_many :customers, through: :project_customers, source: :user
  has_many :notes, dependent: :destroy
  has_many :sprints, dependent: :destroy
  # has_many :tasks, dependent: :destroy
  has_many :tasks, through: :sprints, source: :tasks
  has_many :payments, through: :sprints
  has_many :invitations, dependent: :destroy

  mount_uploader :image, AvatarUploader

  # TODO: Evaluate if we really need all these
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

  def add_customer(customer)
    project_customer = ProjectCustomer.new
    project_customer.project = self
    project_customer.user = customer
    project_customer.save
  end

  # TODO: Scrap this
  def create_event(event_type, message)
    Note.create_event(self, event_type, message)
  end

  def sprint_notes
    # raise NoMethodError # TODO: Scrap this, I freaking hate this
    if current_sprint.notes.timeline.empty?
      current_sprint.notes
    else
      current_sprint.notes.timeline
    end
  end

  def owner?(user = nil)
    return (owner == User.current_user) if user.nil?
    owner == user
  end

  def customer?(user)
    if user.instance_of? String
      user = User.get_account user
      customers.include?(user) if user
      false
    else
      customers.include?(user)
    end
  end

  def get_sprint(number)
    sprints.where(sprint: number).first
  end

  def current_sprint
    get_sprint(sprint_current)
  end

  def current_sprint=(sprint)
    self.sprint_current = sprint.sprint
    unless sprint.open?
      sprint.open = true
      sprint.save
      sprint.reload
    end
    save
    reload
    logger.error('Error changing current sprint on project ID: ' + id.to_s) unless valid?
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

  # TODO: Scrap this if we can, this is crap
  def non_customers
    nc = []
    User.all do |u|
      nc << u unless customer?(current_user)
    end
    nc
  end

  def github_installed?
    owner.github_installed?
  end

  private

  def build_sprints
    # TODO: Test to Verify this is not making an extra useless Sprint, and its making enough
    # total = self.sprint_total + 1
    (1..sprint_total).each do |sprint|
      next unless get_sprint(sprint).nil?
      s = Sprint.new
      s.project = self
      s.sprint = sprint
      s.open = sprint_current == sprint
      s.save
    end
  end
end
