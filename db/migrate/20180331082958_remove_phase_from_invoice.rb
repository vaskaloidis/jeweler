class RemovePhaseFromInvoice < ActiveRecord::Migration[5.2]
  def change
    remove_column :invoices, :phase
  end
end
