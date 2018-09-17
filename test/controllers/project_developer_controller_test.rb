require 'test_helper'

class ProjectDeveloperControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @project = create(:project, :seed_project_users)
    @project_developer = @project.project_developers.first
  end

  test "should leave project" do
    @user = @project_developer.user
    sign_in @user
    get developer_leave_project_url(@project)
    assert_redirected_to root_path
    @project.reload
    assert_not_includes @project.developers, @user
  end

  test "remove customer from project" do
    @user = @project.owner
    sign_in @user
    developer = @project_developer.user
    delete remove_project_developer_url(@project, developer), xhr: true
    assert_response :success
    @project.reload
    assert_not_includes @project.developers, developer
  end
end
