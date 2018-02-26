class SetProjectDefaultValues < ActiveRecord::Migration[5.2]
  def change
    change_column :projects, :readme_file, :string, :default => 'README.md'
    change_column :projects, :readme_remote, :boolean, :default => false
    change_column :projects, :complete, :boolean, :default => false
  end
end
