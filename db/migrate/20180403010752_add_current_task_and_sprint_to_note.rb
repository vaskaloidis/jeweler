class AddCurrentTaskAndSprintToNote < ActiveRecord::Migration[5.2]
  def change
    add_reference :notes, :invoice, foreign_key: true, default: nil
    add_reference :notes, :invoice_item, foreign_key: true, default: nil
  end
end
