# Customers for each Project
# TODO: Refactor this to simply Customer
class ProjectCustomer < ApplicationRecord
  belongs_to :project, required: true
  belongs_to :user, required: true

  # TODO: Verify we need these
  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :project
end
