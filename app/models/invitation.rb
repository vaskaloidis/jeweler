class Invitation < ApplicationRecord
  belongs_to :project

  accepts_nested_attributes_for :project

  def accept
    pc = ProjectCustomer.new
    pc.user = invitation.user
    pc.project = invitation.project
    pc.save
    return pc
  end

end
