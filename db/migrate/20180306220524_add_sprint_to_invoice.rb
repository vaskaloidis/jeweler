class AddSprintToInvoice < ActiveRecord::Migration[5.1]
  def change
    add_column :invoices, :sprint, :integer
  end
end
