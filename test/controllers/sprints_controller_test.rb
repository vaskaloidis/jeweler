# frozen_string_literal: true

require 'test_helper'

class SprintsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @sprint = create(:sprint)
    @user = @sprint.project.owner
    sign_in @user
  end

  test 'should get index' do
    Rails.logger.info(@sprint.project.to_s)
    get project_sprints_url(@sprint.project)
    assert_response :success
  end

  test 'should show sprint' do
    Rails.logger.info(@sprint.to_s)
    get sprint_url(@sprint)
    assert_response :success
  end

  test 'should get edit' do
    get edit_sprint_url(@sprint)
    assert_response :success
  end

  test 'should update sprint' do
    patch sprint_url(@sprint), params: {
      sprint: {
        description: 'updated-sprint-desc'
      }
    }
    assert_redirected_to sprint_url(@sprint)
  end

  test 'edit sprint description' do
    get edit_sprint_description_path(@sprint), xhr: true
    assert_response :success
  end

  test 'render sprint panel' do
    get render_sprint_path(@sprint), xhr: true
    assert_response :success
  end

  test 'set current sprint' do
    project = create(:project)
    next_sprint = project.get_sprint(project.sprint_total - 1)
    if next_sprint.current?
      next_sprint = project.get_sprint(project.sprint_total - 2)
    end
    get set_current_sprint_path(next_sprint), xhr: true
    assert_response :success
    next_sprint.reload
    assert next_sprint.current?
  end

  test 'open sprint' do
    sprint = create(:sprint, open: false)
    get open_sprint_path(sprint), xhr: true
    assert_response :success
  end

  test 'close sprint' do
    get close_sprint_path(@sprint), xhr: true
    assert_response :success
  end
end
