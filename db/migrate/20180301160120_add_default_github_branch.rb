class AddDefaultGithubBranch < ActiveRecord::Migration[5.1]
  def change
    change_column :projects, :github_branch, :string, :default => 'master'
    change_column :projects, :github_secondary_branch, :string, :default => 'master'
  end
end
