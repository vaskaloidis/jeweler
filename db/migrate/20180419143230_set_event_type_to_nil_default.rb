class SetEventTypeToNilDefault < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:notes, :event_type, nil)
  end
end
