class AddSprintTotalToProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :sprint_total, :integer
    add_column :projects, :sprint_current, :integer
  end
end
