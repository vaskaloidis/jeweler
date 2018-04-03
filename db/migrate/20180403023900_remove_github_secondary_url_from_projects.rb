class RemoveGithubSecondaryUrlFromProjects < ActiveRecord::Migration[5.2]
  def change
    remove_column :projects, :github_secondary_url
  end
end
