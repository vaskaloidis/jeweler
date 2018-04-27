class CreateInvoiceItems < ActiveRecord::Migration[5.1]
  def change
    create_table :invoice_items do |t|
      t.text :description
      t.decimal :hours
      t.decimal :rate
      t.string :item_type
      t.boolean :complete
      t.belongs_to :invoice

      t.timestamps
    end
  end
end
