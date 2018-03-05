class AddImageToMultipleTables < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :image, :string
    add_column :notes, :image, :string

  end
end
