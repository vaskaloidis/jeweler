class Project < ApplicationRecord
  belongs_to :owner, :class_name => 'User', :foreign_key => 'user_id', inverse_of: 'owner_projects', required: true
  has_many :project_customers
  has_many :customers, :through => :project_customers, :source => :user
  has_many :notes

  belongs_to :current_task, :class_name => 'InvoiceItem', :foreign_key => 'invoice_item_id', inverse_of: 'project', optional: true

  has_many :invoices
  has_many :invoice_items
  has_many :tasks, :through => :invoices, :source => :invoice_items
  has_many :payments, :through => :invoices
  has_many :invitations

  mount_uploader :image, AvatarUploader

  accepts_nested_attributes_for :customers
  accepts_nested_attributes_for :owner
  accepts_nested_attributes_for :invoices
  accepts_nested_attributes_for :current_task
  accepts_nested_attributes_for :invoice_items
  accepts_nested_attributes_for :notes
  accepts_nested_attributes_for :invitations

  validates :sprint_total, presence: true
  validates :sprint_current, presence: true
  validates :name, presence: true
  validates :github_url, presence: true, uniqueness: true

  def sprints
    return self.invoices.order('sprint::integer ASC')
  end

  # Create an Event
  # Event Types: :task_created, :task_updated, :task_deleted, :sprint_opened, :sprint_closed, :hours_reported,
  #              :task_completed, :sprint_completed, :current_task_changed, :current_sprint_changed,
  #              :payment_request_cancelled]
  def create_event(event_type, message)
    Note.create_event(self, event_type, message)
  end

  def sprint_events
    return self.current_sprint.notes.where(note_type: [:event]).order('created_at DESC').all
  end

  def events
    return self.sprint_events
  end

  def home_page_notes
    return self.sprint_notes
  end

  def sprint_notes
    default_notes = self.current_sprint.notes.where(note_type: [:note, :commit, :project_update, :payment, :payment_request, :demo]).order('created_at DESC').all
    if default_notes.empty?
      default_notes = self.current_sprint.notes.order('created_at DESC').all
    end
    return default_notes
  end

  def is_owner?(user = nil)
    if user.nil?
      if User.current_user == self.owner
        return true
      else
        return false
      end
    else
      if self.owner == user
        return true
      else
        return false
      end
    end
  end


  def is_customer(user = nil)
    if self.customers.include?(user)
      return true
    else
      return false
    end
  end

  def balance
    return self.total_balance
  end

  def total_balance
    unless self.total_cost.nil? or self.total_payment.nil?
      return (self.total_cost - self.total_payment)
    else
      return 0
    end
  end

  def total_hours
    total = 0.0
    self.invoices.each do |invoice|
      total = total + invoice.sprint_hours
    end
    return total
  end

  def total_cost
    total = 0.0
    self.invoices.each do |invoice|
      total = total + invoice.sprint_cost
    end
    return total
  end

  def total_payment
    total = 0.0
    self.invoices.each do |invoice|
      invoice.payments.each do |payment|
        total = total + payment.amount
      end
    end
    return total
  end

  def total_planned_hours
    total = 0.0
    self.invoices.each do |invoice|
      total = total + invoice.sprint_planned_hours
    end
    return total
  end

  def total_planned_cost
    total = 0.0
    self.invoices.each do |invoice|
      total = total + invoice.sprint_planned_cost
    end
    return total
  end

  def get_sprint(number)
    invoices = self.invoices.where(sprint: number)
    if invoices.empty?
      return nil
    else
      return invoices.first
    end
  end

  def current_sprint=(sprint)
    self.sprint_current = sprint.sprint

    unless sprint.open?
      sprint.open = true
      sprint.save
      sprint.reload
    end

    if sprint.invalid?
      logger.error("Error opening Sprint, while setting current sprint (changing sprint) on project ID: " + self.id.to_s);
    end

    if self.invalid?
      logger.error("Error changing current sprint on project ID: " + self.id.to_s)
    end

    return self.save
  end

  def current_sprint
    this_sprint_invoice = self.invoices.where(sprint: self.sprint_current)
    if this_sprint_invoice.empty?
      return nil
    else
      return this_sprint_invoice.first
    end
  end

  def payment_requests
    invoices = Array.new
    self.invoices.each do |invoice|
      if invoice.payment_due == true
        invoices << invoice
      end
    end
    return invoices
  end

  def payment_requested?
    self.invoices.each do |x|
      if x.payment_due == true
        return true
      end
    end
    return false
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
    nc = Array.new
    User.all do |u|
      unless self.is_customer(current_user)
        nc << u
      end
    end
    return nc
  end

  def max_planned_hours
    max = 0.00
    self.invoices.each do |i|
      if max < i.planned_hours
        max = i.planned_hours
      end
    end
    return max
  end

  def max_hours
    max = 0.00
    self.invoices.each do |i|
      if max < i.hours
        max = i.hours
      end
    end
    return max
  end

  def max_payment
    max = 0.00
    self.payments.each do |p|
      if p.amount > max
        max = p.amount
      end
    end
    return max
  end


end
