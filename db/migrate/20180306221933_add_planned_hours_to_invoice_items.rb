class AddPlannedHoursToInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    add_column :invoice_items, :planned_hours, :decimal
  end
end
