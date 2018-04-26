class AddGoogleAnalyticsCodeToProject < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :google_analytics_tracking_code, :string
  end
end
