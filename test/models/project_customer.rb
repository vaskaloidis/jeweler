require 'test_helper'

class ProjectCustomerTest < ActiveSupport::TestCase
  should belong_to(:project)
  should belong_to(:user)


  test 'create a project customer' do
    project_customer = create(:project_customer)
    project = project_customer.project
    customer = project_customer.user

    assert project_customer.valid?
    refute project.nil? and project.name.nil?
    refute customer.nil? and customer.email.nil?
  end

end