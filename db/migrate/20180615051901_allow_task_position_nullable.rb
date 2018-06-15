class AllowTaskPositionNullable < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :position, :integer, :null => true
  end
end
