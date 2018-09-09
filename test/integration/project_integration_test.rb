require 'test_helper'

class ProjectIntegrationTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "project gets created" do
    @user = create(:user)
    sign_in @user

    get new_project_path
    assert_response :success

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

    project.sprints.each_with_index do |sprint, index|
      assert_equal sprint.sprint, (index + 1)
    end

    assert_equal project.owner.id, @user.id

    # Assert Current-Sprint exists (and Open)
    @found = false
    project.sprints.each do |sprint|
      next unless project.current_sprint == sprint
      @found = true
      assert sprint.open && sprint.open?
      refute sprint.closed?
    end
    assert @found
  end

  test 'should update project' do
    # @user = create(:owner)
    @project = create(:project, :seed_tasks_notes, :seed_project_users)
    @user = @project.owner
    sign_in @user

    get edit_project_url(@project)
    assert_response :success, @response.body.to_s

    project_update = attributes_for(:update_project)

    patch project_url(@project), params: {project: project_update}
    assert_redirected_to project_url(@project), @response.body.to_s

    @project.reload
    # @project = Project.find(@project)

    assert_equal(project_update[:name], @project.name)
    assert_equal(project_update[:description], @project.description)
    assert_equal(project_update[:language], @project.language)
  end

end
