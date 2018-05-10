class AddStripeParamsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :stripe_account_id, :string
    add_column :users, :stripe_type, :string
    add_column :users, :stripe_token, :string
    add_column :users, :stripe_key, :string
  end
end
