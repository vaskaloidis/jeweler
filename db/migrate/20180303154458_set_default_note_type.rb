class SetDefaultNoteType < ActiveRecord::Migration[5.1]
  def change
    change_column :notes, :note_type, :integer, :default => 1
  end
end
