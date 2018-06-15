class SetSprintsSprintToNullableFalse < ActiveRecord::Migration[5.2]
  def change
    change_column_null :sprints, :sprint, false
  end
end
