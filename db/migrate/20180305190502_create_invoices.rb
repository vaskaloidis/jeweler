class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.integer :sprint_
      t.date :payment_due_date
      t.boolean :payment_due
      t.text :description
      t.belongs_to :project

      t.timestamps
    end
  end
end
