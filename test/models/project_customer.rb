require 'test_helper'

class ProjectCustomerTest < ActiveSupport::TestCase
  should belong_to(:project)
  should belong_to(:user)

  test 'create a valid project customer' do
    project_customer = create(:project_customer)
    project = project_customer.project
    customer = project_customer.user

    assert project_customer.valid?
    assert !project.nil? && project.instance_of?(Project)
    assert customer.valid? && customer.instance_of?(User)
    refute customer.id.nil?
  end

end