# frozen_string_literal: true

require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  # Setup runs before EVERY test
  setup do
    @owner = create(:owner)
    @project = create(:project, :seed_tasks_notes, :seed_project_users, sprint_current: 7, sprint_total: 9, owner: @owner)
    @customer = @project.customers.first
    @developer = @project.developers.first
  end

  test 'owner should get settings' do
    sign_in @owner
    get project_settings_url(@project)
    assert_response :success, @response.body.to_s
    sign_out @owner
  end

  test 'developer should get settings' do
    sign_in @developer
    get project_settings_url(@project)
    assert_response :success, @response.body.to_s
  end

  test 'customer should get settings' do
    sign_in @customer
    get project_settings_url(@project)
    assert_response :success, @response.body.to_s
  end

  test 'owner should get users' do
    sign_in @owner
    get project_users_url(@project)
    assert_response :success, @response.body.to_s
  end

  test 'owner should get index' do
    sign_in @owner
    get projects_url
    assert_response :success, @response.body.to_s
  end

  test 'customer should get index' do
    project2 = create(:project, owner: @developer)
    project2.add_customer(@customer).add_developer(@owner)
    project2.current_sprint.request_payment!
    sign_in @customer
    get projects_url
    assert_response :success, @response.body.to_s
  end

  test 'developer should get index' do
    sign_in @developer
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
    new_project = attributes_for(:new_project, sprint_current: 2, sprint_total: 4, owner: @owner)
    assert_difference('Project.count') do
      post projects_url, params: { project: new_project }
    end
    created_project = Project.last
    assert created_project&.valid?
    assert_equal new_project[:name], created_project.name
    assert_equal new_project[:language], created_project.language
    assert_equal new_project[:description], created_project.description
    assert_equal new_project[:sprint_current], created_project.sprint_current
    assert_equal new_project[:sprint_total], created_project.sprint_total
    assert_nil   created_project.github_repo_id
    assert_nil   created_project.github_webhook_id
    assert_equal new_project[:stage_website_url], created_project.stage_website_url
    assert_equal new_project[:demo_url], created_project.demo_url
    assert_equal new_project[:prod_url], created_project.prod_url
    assert_equal @owner, created_project.owner
    (1..4).each { |s| assert created_project.sprint(s) }
    refute created_project.sprint(5)
    refute created_project.sprint(0)
    assert_redirected_to project_url(created_project)
    sign_out @owner
  end

  test 'owner should show project' do
    sign_in @owner
    get project_url(@project)
    assert_response :success, @response.body.to_s
    sign_out @owner
  end

  test 'customer should show project' do
    sign_in @customer
    get project_url(@project)
    assert_response :success, @response.body.to_s
    sign_out @customer
  end

  test 'developer should show project' do
    sign_in @developer
    get project_url(@project)
    assert_response :success, @response.body.to_s
    sign_out @developer
  end

  test 'should get edit' do
    sign_in @owner
    get edit_project_url(@project)
    assert_response :success, @response.body.to_s
    sign_out @owner
  end

  test 'should update project' do
    sign_in @owner
    project_update = attributes_for(:update_project)
    patch project_url(@project), params: { project: project_update }
    @project.reload
    assert_equal project_update[:name], @project.name
    assert_equal project_update[:language], @project.language
    assert_equal project_update[:description], @project.description
    assert_equal project_update[:sprint_current], @project.sprint_current
    assert_equal project_update[:sprint_total], @project.sprint_total
    assert_nil   @project.github_repo_id
    assert_nil   @project.github_webhook_id
    assert_equal project_update[:stage_website_url], @project.stage_website_url
    assert_equal project_update[:demo_url], @project.demo_url
    assert_equal project_update[:prod_url], @project.prod_url
    assert_equal @owner, @project.owner
    assert_redirected_to project_url(@project), @response.body.to_s
    sign_out @owner
  end

  test 'should destroy project' do
    sign_in @owner
    assert_difference('Project.count', -1) do
      delete project_url(@project)
    end
    assert_redirected_to projects_url, @response.body.to_s
    sign_out @owner
  end
end
