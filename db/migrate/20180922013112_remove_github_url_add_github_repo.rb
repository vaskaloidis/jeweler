class RemoveGithubUrlAddGithubRepo < ActiveRecord::Migration[5.2]
  def change
    remove_index :projects, :github_url
    rename_column :projects, :github_url, :string
    add_column :projects, :github_repo, :string
  end
end
