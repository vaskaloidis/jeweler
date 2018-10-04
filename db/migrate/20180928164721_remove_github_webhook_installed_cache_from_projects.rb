class RemoveGithubWebhookInstalledCacheFromProjects < ActiveRecord::Migration[5.2]
  def change
    remove_column :projects, :github_webhook_installed_cache
    rename_column :projects, :github_repo, :github_repo_id
  end
end
