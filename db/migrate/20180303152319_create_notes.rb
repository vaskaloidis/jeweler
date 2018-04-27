class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes do |t|
      t.string :content
      t.integer :note_type
      t.text :content
      t.string :git_commit_id
      t.belongs_to :project, foreign_key: true
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
