class AddEventTypeToNotes < ActiveRecord::Migration[5.1]
  def change
    add_column :notes, :event_type, :integer
  end
end
