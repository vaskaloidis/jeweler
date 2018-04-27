class SetInvoiceItemsDefaultZero < ActiveRecord::Migration[5.1]
  def change
    change_column :invoice_items, :hours, :decimal, :default => 0.0
    change_column :invoice_items, :planned_hours, :decimal, :default => 0.0
    change_column :invoice_items, :rate, :decimal, :default => 0.0
  end
end
