class Note < ApplicationRecord
  enum note_type: [ :note, :demo, :commit, :financial, :task ]

  belongs_to :project
  has_many :discussions
  belongs_to :author, :class_name => 'User', :foreign_key => 'user_id', inverse_of: 'notes', required: true

  accepts_nested_attributes_for :author
end
