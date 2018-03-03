class SetDefaultNoteType < ActiveRecord::Migration[5.2]
  def change
    change_column :notes, :note_type, :integer, :default => 1
  end
end
