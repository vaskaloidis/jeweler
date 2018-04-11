class Discussion < ApplicationRecord
  belongs_to :note
  belongs_to :user

  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :note
end
