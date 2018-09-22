class ChangeGitHubRepoType < ActiveRecord::Migration[5.2]
  def change
    remove_column :projects, :github_repo, :integer
    add_column :projects, :github_repo, :integer, default: nil
  end
end
