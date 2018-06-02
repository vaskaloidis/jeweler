# frozen_string_literal: true

# The main Class for Jeweler, used for every Project
class Project < ApplicationRecord
  include Averageable
  include Totalable
  include Maxable

  after_save :build_sprints, if: ->(obj){ obj.sprint_total.present? and obj.sprint_total_changed? }

  belongs_to :owner, class_name: 'User', foreign_key: 'user_id', inverse_of: 'owner_projects', required: true, dependent: :destroy
  has_many :project_customers, dependent: :destroy
  has_many :customers, through: :project_customers, source: :user, dependent: :destroy
  has_many :notes, dependent: :destroy

  belongs_to :current_task, class_name: 'Task', foreign_key: 'task_id', inverse_of: 'project', optional: true

  has_many :sprints, -> {order 'sprint'}, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :tasks, through: :sprints, source: :tasks, dependent: :destroy
  has_many :payments, through: :sprints, dependent: :destroy
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

  # Create an Event
  def create_event(event_type, message)
    Note.create_event(self, event_type, message)
  end

  def events
    return Hash.new if current_sprint.nil?
    return Hash.new if current_sprint.notes.empty?
    current_sprint.notes.where(note_type: [:event]).order('created_at DESC').all
  end

  def sprint_notes
    return Hash.new if self.current_sprint.nil?
    default_notes = self.current_sprint.notes.where(note_type: %i[note commit project_update payment payment_request demo]).order('created_at DESC').all
    if default_notes.empty?
      default_notes = self.current_sprint.notes.order('created_at DESC').all
    end
    default_notes
  end

  def owner?(user = nil)
    return (owner == User.current_user) if user.nil?
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

  def get_sprint(number)
    sprints.where(sprint: number).first
  end

  def current_sprint
    get_sprint(self.sprint_current)
  end

  def current_sprint=(sprint)
    self.sprint_current = sprint.sprint
    unless sprint.open?
      sprint.open = true
      sprint.save
      sprint.reload
    end
    reload
    unless save and valid
      logger.error('Error changing current sprint on project ID: ' + id.to_s)
    end
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

  private

  def build_sprints
    # TODO: Test to Verify this is not making an extra useless Sprint, and its making enough
    # total = self.sprint_total + 1
    (1..sprint_total).each do |sprint|
      next unless self.get_sprint(sprint).nil?
      s = Sprint.new
      s.project = self
      s.sprint = sprint
      s.open = self.sprint_current == sprint
      s.save
    end
  end

end
