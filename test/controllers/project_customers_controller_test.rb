require 'test_helper'

class ProjectCustomersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @customer
    @project = create(:project, :seed_project_users)

    @project_customer = @project.project_customers.first
  end

  test "should leave project" do
    @user = @project_customer.user
    sign_in @user
    get customer_leave_project_url(@project, @user)
    assert_redirected_to root_path
    @project.reload
    assert_not_includes @project.customers, @user
  end

  test "remove customer from project" do
    @user = @project.owner
    sign_in @user
    customer = @project_customer.user
    delete remove_project_customer_url(@project, customer), xhr: true
    assert_response :success
    @project.reload
    assert_not_includes @project.customers, customer
  end
end
