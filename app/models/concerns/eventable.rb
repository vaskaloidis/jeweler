module Eventable
  extend ActiveSupport::Concern

  included do
    has_many :events, as: :eventable, dependent: :destroy

    accepts_nested_attributes_for :events
  end
  #



end