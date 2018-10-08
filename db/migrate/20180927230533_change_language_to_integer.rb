class ChangeLanguageToInteger < ActiveRecord::Migration[5.2]
  def change
    remove_column :projects, :language
    add_column :projects, :language, :integer, default: nil
  end
end
