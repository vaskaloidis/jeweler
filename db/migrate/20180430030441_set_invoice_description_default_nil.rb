class SetInvoiceDescriptionDefaultNil < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:invoices, :description, nil)
  end
end
