class AddActionToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :action, :string
  end
end
