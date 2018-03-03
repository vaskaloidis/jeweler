class ProjectCustomer < ApplicationRecord
  belongs_to :project
  belongs_to :user

  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :project

  def has_owner(user)
    if self.project.has_owner(user)
      return true
    else
      return false
    end
  end

end
