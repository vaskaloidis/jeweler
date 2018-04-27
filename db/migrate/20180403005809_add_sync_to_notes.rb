class AddSyncToNotes < ActiveRecord::Migration[5.1]
  def change
    add_column :notes, :sync, :boolean, default: false
  end
end
