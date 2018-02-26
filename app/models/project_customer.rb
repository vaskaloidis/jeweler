class ProjectCustomer < ApplicationRecord
  belongs_to :project
  belongs_to :user

  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :project

end
