class ProjectNameNotNullable < ActiveRecord::Migration[5.2]
  def change
    change_column :projects, :name, :string, null: false
  end
end
