class AddLetterToInvoiceItem < ActiveRecord::Migration[5.2]
  def change
    add_column :invoice_items, :position, :integer
    add_index(:invoice_items, :position)
    add_column(:invoice_items, :deleted, :boolean, default: false)
  end
end
