class AddOpenToInvoice < ActiveRecord::Migration[5.2]
  def change
    add_column :invoices, :open, :boolean, :default => false
    change_column :invoices, :payment_due, :boolean, :default => false
  end
end
