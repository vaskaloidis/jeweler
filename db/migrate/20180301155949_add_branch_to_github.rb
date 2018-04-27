class AddBranchToGithub < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :github_branch, :string
    add_column :projects, :github_secondary_branch, :string
  end
end
