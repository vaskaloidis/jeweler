# frozen_string_literal: true

require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  # Setup runs before EVERY test
  setup do
    # @owner = create(:owner)
    @project = create(:project, :seed_tasks_notes, :seed_project_users)
    @owner = @project.owner
    @customer = @project.project_customers.first.user
  end

  test 'owner should get index' do
    sign_in @owner
    get projects_url
    assert_response :success, @response.body.to_s
  end

  test 'customer should get index' do
    sign_in @customer
    get projects_url
    assert_response :success, @response.body.to_s
  end

  test 'should get new' do
    sign_in @owner
    get new_project_url
    assert_response :success, @response.body.to_s
  end

  test 'should create project and corresponding sprints' do
    sign_in @owner
    new_project = attributes_for(:new_project)
    assert_difference('Project.count') do
      post projects_url, params: { project: new_project }
    end
    project = Project.last
    assert project and project.valid?
    assert_equal new_project[:name], project.name
    assert_equal new_project[:language], project.language
    assert_equal new_project[:description], project.description
    assert_equal new_project[:github_url], project.github_url
    assert_equal new_project[:stage_website_url], project.stage_website_url
    assert_equal new_project[:demo_url], project.demo_url
    assert_equal new_project[:prod_url], project.prod_url
    # TODO: assert_equal new_project[:owner], @owner
    assert_redirected_to project_url(project)
  end

  test 'owner should show project' do
    sign_in @owner
    get project_url(@project)
    assert_response :success, @response.body.to_s
  end

  test 'customer should show project' do
    sign_in @customer
    get project_url(@project)
    assert_response :success, @response.body.to_s
  end

  test 'should get edit' do
    sign_in @owner
    get edit_project_url(@project)
    assert_response :success, @response.body.to_s
  end

  test 'should update project' do
    sign_in @owner
    project_update = attributes_for(:update_project)
    patch project_url(@project), params: { project: project_update }
    assert_redirected_to project_url(@project), @response.body.to_s
  end

  test 'should destroy project' do
    sign_in @owner
    assert_difference('Project.count', -1) do
      delete project_url(@project)
    end
    assert_redirected_to projects_url, @response.body.to_s
  end
end
