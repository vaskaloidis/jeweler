class RenameOauthColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :oath, :oauth
  end
end
