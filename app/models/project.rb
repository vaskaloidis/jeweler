class Project < ApplicationRecord
  belongs_to :owner, :class_name => 'User', :foreign_key => 'user_id', inverse_of: 'owner_projects', required: true
  has_many :project_customers
  has_many :customers, :through => :project_customers, :source => :user
  has_many :notes

  has_many :invoices
  has_many :invoice_items
  has_many :tasks, :through => :invoices, :source => :invoice_items
  has_many :payments, :through => :invoices

  mount_uploader :image, AvatarUploader

  accepts_nested_attributes_for :customers
  accepts_nested_attributes_for :owner
  accepts_nested_attributes_for :invoices

  def get_sprint(number)
    self.invoices.where(sprint: number).first
  end

  def current_sprint
    return self.invoices.where(sprint: self.phase_current).first
  end

  def payment_requested?
    self.invoices.each do |i|
      if i.payment_due == true
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

  def is_owner(user)
    if self.owner == user
      return true
    else
      return false
    end
  end


  def is_customer(user)
    if self.customers.include?(user)
      return true
    else
      return false
    end
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


end
