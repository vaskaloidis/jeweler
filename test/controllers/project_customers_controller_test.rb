require 'test_helper'

class ProjectCustomersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @owner = create(:user)
    @customer = create(:user)
    @project = create(:project, owner: @owner)
    @project_customer = @project.project_customers.create(user: @customer)
  end

  test "should leave project" do
    sign_in @customer
    get customer_leave_project_url(@project, @customer)
    assert_redirected_to root_path
    @project.reload
    assert_not_includes @project.customers, @customer
  end

  test "remove customer from project" do
    sign_in @owner
    customer = @project_customer.user
    delete remove_project_customer_url(@project, @customer), xhr: true
    assert_response :success
    @project.reload
    assert_not_includes @project.customers, @customer
  end
end
