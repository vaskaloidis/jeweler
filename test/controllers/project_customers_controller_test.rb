require 'test_helper'

class ProjectCustomersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @project_customer = create(:project_customer)
    @project = @project_customer.project
  end

  test "should leave project" do
    @user = @project_customer.user
    sign_in @user
    get leave_project_url(@project, @user)
    assert_redirected_to root_path
    @project.reload
    assert_not_includes @project.customers, @user
  end

  test "remove customer from project" do
    @user = @project.owner
    sign_in @user
    customer = @project_customer.user
    delete remove_customer_url(@project, customer), xhr:true
    assert_response :success
    @project.reload
    assert_not_includes @project.customers, customer
  end

  test "customer should not be able to remove customers from project" do
  end

  test "should get index" do
    @user = @project.owner
    sign_in @user
    get project_project_customers_url(@project)
    assert_response :success
  end
end
