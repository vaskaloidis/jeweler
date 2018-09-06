class AddUserToInvitations < ActiveRecord::Migration[5.2]
  def change
    add_reference :invitations, polymorphic: true, index: true
  end
end
