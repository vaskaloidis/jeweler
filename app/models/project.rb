class Project < ApplicationRecord
  belongs_to :owner, :class_name => 'User', :foreign_key => 'user_id', inverse_of: 'owner_projects', required: true
  has_many :project_customers
  has_many :customers, :through => :project_customers, :source => :user
  has_many :notes

  accepts_nested_attributes_for :customers
  accepts_nested_attributes_for :owner

  def has_owner(user)
    if self.owner == user
      return true
    else
      return false
    end
  end

  def has_customer(user)
    if self.customer_projects.include?(user)
      return true
    else
      return false
    end
  end

  def non_customers
    # User.all do |u|

    unless @project.has_owner(current_user)

    end
  end


end
