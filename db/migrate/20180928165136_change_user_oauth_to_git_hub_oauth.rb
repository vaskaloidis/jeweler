class ChangeUserOauthToGitHubOauth < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :oauth, :github_oauth
    change_column :users, :github_oauth, :string, default: nil
    change_column :projects, :github_repo_id, :integer, default: nil
  end
end
