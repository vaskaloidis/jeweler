class RenameOauthColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :oath, :oauth
  end
end
