class AddInvoiceItemsReferenceToProject < ActiveRecord::Migration[5.2]
  def change
    add_reference :projects, :invoice_item, index: true
  end
end
