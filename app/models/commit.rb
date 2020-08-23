class Commit < ApplicationRecord
  include Eventable

  has_one :project, through: :sprint
  belongs_to :sprint, required: true
  belongs_to :task
    include Eventable
  # has_many :events, as: :eventable, dependent: :destroy

end
