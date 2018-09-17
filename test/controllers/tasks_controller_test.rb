# frozen_string_literal: true

require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @task = create(:task)
    @user = create(:user)
    @project = create(:project, :seed_tasks_notes, :seed_project_users, owner: @user)
    sign_in @user
  end

  test 'should get new' do
    sprint = @project.sprints.first
    assert sprint
    refute sprint.nil?
    get new_sprint_task_path(sprint), xhr: true
    assert_response :success
    assert_equal 'text/javascript', @response.content_type
  end

  test 'should show a task' do
    get task_url(@task), xhr: true
    assert_response :success
    assert_equal 'text/javascript', @response.content_type
  end

  test 'should create task' do
    developer = create(:user)
    @project.add_developer(developer)
    sprint = @project.get_sprint(3)
    new_task = attributes_for(:task, created_by_id: @user.id, assigned_to_id: developer.id, sprint_id: @project.current_sprint.id, description: 'new task desc', rate: 13, planned_hours: 14, hours: 15)
    assert_difference('Task.count') do
      post sprint_tasks_url(sprint), params: { task: new_task }, xhr: true
    end
    assert_response :success
    assert_equal 'text/javascript', @response.content_type

    task = Task.last
    assert_equal new_task[:description], task.description
    assert_equal new_task[:hours].to_f, task.hours.to_f
    assert_equal new_task[:planned_hours].to_f, task.planned_hours.to_f
    assert_equal new_task[:rate].to_f, task.rate.to_f
    assert_equal new_task[:sprint_id], task.sprint.id
    assert_equal new_task[:created_by_id], @user.id
    assert_equal new_task[:assigned_to_id], developer.id
  end

  test 'should edit the task' do
    get edit_task_url(@task), xhr: true
    assert_response :success
    assert_equal 'text/javascript', @response.content_type
  end

  test 'should update task' do
    developer1 = create(:user)
    developer2 = create(:user)
    @project.add_developer(developer1)
    @project.add_developer(developer2)
    task = @project.current_sprint.tasks.create(created_by_id: @user.id, description: 'original-desc', rate: 1, planned_hours: 2, hours: 3, complete: false)
    task_update = { created_by_id: developer1.id, assigned_to_id: developer2.id, sprint_id: task.sprint.id, description: 'updated desc', rate: 12, planned_hours: 13, hours: 14, complete: true}
    patch task_url(task), params: { task: task_update }, xhr: true
    assert_response :success
    task.reload
    assert_equal task_update[:description], task.description
    assert_equal task_update[:hours].to_f, task.hours.to_f
    assert_equal task_update[:planned_hours].to_f, task.planned_hours.to_f
    assert_equal task_update[:rate].to_f, task.rate.to_f
    assert_equal task_update[:created_by_id], developer1.id
    assert_equal task_update[:assigned_to_id], developer2.id
  end

  test 'should set task to deleted status' do
    task = create(:task, deleted: false)
    delete task_url(task), xhr: true
    assert_response :success
    assert_equal 'text/javascript', @response.content_type
    task.reload
    assert task.deleted
  end

  test 'should complete task' do
    task = create(:task, complete: false)
    get complete_task_path(task), xhr: true
    assert_response :success
    assert_equal 'text/javascript', @response.content_type
    task.reload
    assert task.complete
  end

  test 'should uncomplete task' do
    task = create(:task, complete: true)
    get uncomplete_task_path(task), xhr: true
    assert_response :success
    assert_equal 'text/javascript', @response.content_type
    task.reload
    refute task.complete
  end

  test 'set current task' do
    project = create(:project, :seed_tasks_notes, :seed_project_users)
    sprint = project.current_sprint
    task = sprint.tasks.first
    get set_current_task_path(task), xhr: true
    assert_equal 'text/javascript', @response.content_type
    assert_response :success
    task.reload
    assert task.current?
  end

  test 'should cancel task update' do
    get cancel_task_update_path(@task.sprint), xhr: true
    assert_response :success
    assert_equal 'text/javascript', @response.content_type
  end
end
