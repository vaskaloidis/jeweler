# frozen_string_literal: true

class Note < ApplicationRecord
  enum note_type: %i[owner_note developer_note customer_note project_update_note demo]

  default_scope { order('created_at DESC') }

  has_many :events, as: :eventable, dependent: :destroy
  has_many :discussions, dependent: :destroy
  has_one :project

  belongs_to :user, class_name: 'User', foreign_key: 'user_id', inverse_of: 'notes', required: true
  belongs_to :sprint
  has_one :project, through: :sprint
  mount_uploader :image, AvatarUploader

  accepts_nested_attributes_for :discussions
  accepts_nested_attributes_for :events

  # TODO: Refactor / Scrap this (probably a better way to do it)
  def self.note_types
    note_types = []
    note_types << 'all'
    note_types << 'note'
    note_types << 'project_update'
    note_types << 'demo'
    note_types << 'commit'
    note_types << 'payment'
    note_types << 'payment_request'
    note_types << 'event'
    note_types
  end

end
