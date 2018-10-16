class AddContentToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :details, :string
  end
end
