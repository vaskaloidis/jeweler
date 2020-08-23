# frozen_string_literal: true

# The main Class for Jeweler, used for every Project
class Project < ApplicationRecord
  include Averageable
  include Totalable
  include Maxable

  after_save :build_sprints, if: ->(obj) {obj.sprint_total.present? || obj.sprint_total_changed?}

  belongs_to :current_task, class_name: 'Task', foreign_key: 'task_id', inverse_of: 'project', optional: true, dependent: :delete
  belongs_to :owner, class_name: 'User', foreign_key: 'user_id', inverse_of: 'owner_projects', required: true, dependent: :delete
  has_many :project_developers, dependent: :destroy
  has_many :developers, through: :project_developers, source: :user, dependent: :nullify
  has_many :project_customers, dependent: :destroy
  has_many :customers, through: :project_customers, source: :user, dependent: :nullify

    include Eventable
  # has_many :events, as: :eventable, dependent: :destroy

  has_many :notes, dependent: :destroy
  has_many :sprints, dependent: :destroy
  has_many :tasks, through: :sprints, dependent: :destroy
  has_many :payments, through: :sprints, dependent: :nullify
  has_many :invitations, dependent: :destroy

  mount_uploader :image, AvatarUploader

  accepts_nested_attributes_for :developers
  accepts_nested_attributes_for :customers
  accepts_nested_attributes_for :owner
  accepts_nested_attributes_for :sprints
  accepts_nested_attributes_for :current_task
  accepts_nested_attributes_for :tasks
  accepts_nested_attributes_for :notes
  accepts_nested_attributes_for :events
  accepts_nested_attributes_for :invitations

  validates :owner, presence: true
  validates :sprint_total, presence: true
  validates :sprint_current, presence: true
  validates :name, presence: true
  validate :validate_sprint_count

  def github
    GitHubRepo.new(self)
  end

  def create_event(event_type, message)
    Note.create_event(self, event_type, message)
  end

  def sprint_notes
    # raise NoMethodError # TODO: Scrap this, I freaking hate this
    if current_sprint.events.timeline.empty?
      current_sprint.events
    else
      current_sprint.events.timeline
    end
  end

  def owner?(user = nil)
    return (owner == User.current_user) if user.nil?
    owner == user
  end

  def add_developer(user)
    project_developers.create!(user: user)
    reload
    self
  end

  def add_customer(user)
    project_customers.create!(user: user)
    reload
    self
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

  def role(user)
    Role.new(project: self, user: user)
  end

  def sprint(number)
    sprints.where(sprint: number).first
  end

  # TODO: Remove this in a seperate commit
  # to prevent un-reversable issues
  def get_sprint(number)
    sprint(number)
  end

  def current_sprint
    get_sprint(sprint_current)
  end

  def payment_requests
    sprints.where(payment_due: true).all
  end

  def payment_requested?
    sprints.any? { |s| s.payment_due? }
  end

  def users
    @users ||= begin
      total = []
      total << owner
      total.concat customers
      total.concat developers
      total
    end
  end

  def current_sprint=(sprint)
    self.sprint_current = sprint.sprint
    sprint.update!(open: true) unless sprint.open?
  end

  private

  def validate_sprint_count
    if sprint_current > sprint_total
      errors.add(:sprint_current, 'Current-Sprint must be less than or equal to Total-Sprint.')
    end
    unless sprint_current.positive?
      errors.add(:sprint_current, 'Current-Sprint must be a positive number.')
    end
    unless sprint_total.positive?
      errors.add(:sprint_total, 'Total-Sprints must be a positive number.')
    end
  end

  def build_sprints
    (1..sprint_total).each do |sprint|
      next unless get_sprint(sprint).nil?
      sprints.create!(sprint: sprint, open: (sprint_current == sprint))
    end
  end

end
