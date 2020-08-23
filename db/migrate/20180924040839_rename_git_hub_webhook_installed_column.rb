class RenameGitHubWebhookInstalledColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :projects, :github_webhook_installed, :github_webhook_installed_cache
  end
end
