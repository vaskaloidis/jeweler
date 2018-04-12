class ChangeHerokuTokenDefaultNil < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:projects, :heroku_token, nil)
  end
end
