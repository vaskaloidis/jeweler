class CreateGitHubUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :git_hub_users do |t|

      t.timestamps
    end
  end
end
