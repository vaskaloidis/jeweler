class AddHerokuTokenToProject < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :heroku_token, :string
  end
end
