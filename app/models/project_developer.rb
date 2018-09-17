class ProjectDeveloper < ApplicationRecord
  belongs_to :project, required: true
  belongs_to :user, required: true

  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :project
end
