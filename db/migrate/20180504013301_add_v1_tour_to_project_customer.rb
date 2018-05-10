class AddV1TourToProjectCustomer < ActiveRecord::Migration[5.2]
  def change
    add_column :project_customers, :v1_tour, :boolean, default: false
  end
end
