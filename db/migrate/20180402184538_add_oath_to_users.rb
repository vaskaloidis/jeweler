class AddOathToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :oath, :string
  end
end