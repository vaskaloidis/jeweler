class SetInvoiceItemCompletedDefaultFalse < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:invoice_items, :complete, false)
  end
end
