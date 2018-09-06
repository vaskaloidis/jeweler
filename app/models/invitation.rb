class Invitation < ApplicationRecord
  enum user_type: [:customer, :developer]
  belongs_to :project, required: true
  accepts_nested_attributes_for :project
  default_scope {order('created_at DESC')}

  def user
    search = User.where(email: email).all
    false if search.count.zero?
    search.first
  end

  def accept!
    false unless user
    result = if customer?
               project.project_customers.create(user: user)
             else
               project.project_developers.create(user: user)
             end
    destroy!
    result
  end

  def decline!
    destroy!
  end

end
