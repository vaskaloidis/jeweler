class Commit < ApplicationRecord
  include Eventable

  has_one :project, through: :sprint
  belongs_to :sprint, required: true
  belongs_to :task
end
