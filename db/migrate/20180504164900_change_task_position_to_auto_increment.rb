class ChangeTaskPositionToAutoIncrement < ActiveRecord::Migration[5.2]
  def change
    change_column :invoice_items, :position, :int, null: false, unique: true, auto_increment: true
  end
end
