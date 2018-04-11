class CreateInvitations < ActiveRecord::Migration[5.1]
  def change
    create_table :invitations do |t|
      t.string :email
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
