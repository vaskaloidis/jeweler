class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.integer :payment_type
      t.string :payment_identifier
      t.string :payment_note
      t.decimal :amount
      t.belongs_to :invoice
      t.belongs_to :user

      t.timestamps
    end
  end
end
