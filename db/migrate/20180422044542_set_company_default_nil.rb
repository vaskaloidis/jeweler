class SetCompanyDefaultNil < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:users, :company, '')
  end
end
