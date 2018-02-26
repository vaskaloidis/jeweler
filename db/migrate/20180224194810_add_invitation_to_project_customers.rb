class AddInvitationToProjectCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :project_customers, :invitation, :string
  end
end
