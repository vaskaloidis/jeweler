class Invitation < ApplicationRecord
  belongs_to :project, required: true
  accepts_nested_attributes_for :project

  def accept
    pc = ProjectCustomer.new
    pc.user = user
    pc.project = project
    pc.save
    pc
  end

end
