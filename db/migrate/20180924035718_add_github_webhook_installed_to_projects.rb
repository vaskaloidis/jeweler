class AddGithubWebhookInstalledToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :github_webhook_installed, :boolean, default: false
  end
end
