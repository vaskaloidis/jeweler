# frozen_string_literal: true

require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  # Setup runs before EVERY test
  setup do
    # @user = create(:owner)
    @project = create(:project)
    @user = @project.owner
    sign_in @user
  end

  test 'should get index' do
    get projects_url
    assert_response :success, @response.body.to_s
  end

  test 'should get new' do
    get new_project_url
    assert_response :success, @response.body.to_s
  end

  test 'should create project and corresponding sprints' do
    new_project = attributes_for(:new_project)
    assert_difference('Project.count') do
      post projects_url, params: { project: new_project }
    end

    project = Project.last
    assert project and project.valid?

    assert_redirected_to project_url(project)
    assert_equal(project.name, new_project[:name])
    assert_equal(project.description, new_project[:description])
    assert_equal(project.language, new_project[:language])
    assert_equal(project.github_url, new_project[:github_url])

    project.sprints.each do |sprint, index|
      assert_equal sprint.sprint, (index+1)
    end

  end

  test 'should show project' do
    get project_url(@project)
    assert_response :success, @response.body.to_s
  end

  test 'should get edit' do
    get edit_project_url(@project)
    assert_response :success, @response.body.to_s
  end

  test 'should update project' do
    project_update = attributes_for(:update_project)

    patch project_url(@project), params: { project: project_update }
    # assert_redirected_to project_url(@project), @response.body.to_s

    @project.reload
    # @project = Project.find(@project)

    assert_equal(project_update[:name], @project.name)
    assert_equal(project_update[:description], @project.description)
    assert_equal(project_update[:language], @project.language)
  end

  test 'should destroy project' do
    assert_difference('Project.count', -1) do
      delete project_url(@project)
    end

    assert_redirected_to projects_url, @response.body.to_s
  end

  private
  def save_response_to_file(response)
    File.open("response.txt", "w") { |file| file.write response.body.to_s }
  end
end
