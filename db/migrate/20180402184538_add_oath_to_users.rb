class AddOathToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :oath, :string
  end
end
