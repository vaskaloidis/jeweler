class AddSprintToInvoice < ActiveRecord::Migration[5.2]
  def change
    add_column :invoices, :sprint, :integer
  end
end
