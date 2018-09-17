require 'test_helper'

class ProjectCustomersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "customer should leave project" do
    @owner = create(:user)
    @customer = create(:user)
    @project = create(:project, owner: @owner)
    @project_customer = @project.add_customer(@customer)
    sign_in @customer
    get customer_leave_project_url(@project)
    assert_redirected_to root_path
    @project.reload
    assert_not_includes @project.customers, @customer
  end

  test "remove customer from project" do
    @owner = create(:user)
    @customer = create(:user)
    @project = create(:project, owner: @owner)
    @project_customer = @project.add_customer(@customer)
    sign_in @owner
    delete remove_project_customer_url(@project, @customer), xhr: true
    assert_response :success
    @project.reload
    assert_not_includes @project.customers, @customer
  end
end
