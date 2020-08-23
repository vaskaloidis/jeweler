class AddGitHubWebhookIdToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :github_webhook_id, :integer, default: nil
  end
end
