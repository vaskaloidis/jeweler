# frozen_string_literal: true

require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @task = create(:task)
    @project = create(:project)
    @user = @project.owner
    sign_in @user
    # TODO: Security Checks / Permissions Checks (Customer VS. Owner)
  end

  test 'should get new' do
    get new_project_sprint_task_url(@project, @project.sprints.first), xhr: true

    assert_response :success
    assert_equal 'text/javascript', @response.content_type
  end

  test 'should create task' do
    sprint = create(:sprint)
    new_task = attributes_for(:new_task)
    new_task[:sprint_id] = sprint.id
    Rails.logger.info new_task.inspect
    assert_difference('Task.count') do
      post tasks_url, params: { task: new_task }, xhr: true
    end
    assert_response :success
    assert_equal 'text/javascript', @response.content_type

    task = Task.last
    assert_equal new_task[:description], task.description
    assert_equal new_task[:hours].to_f, task.hours.to_f
    assert_equal new_task[:planned_hours].to_f, task.planned_hours.to_f
    assert_equal new_task[:rate].to_f, task.rate.to_f
    assert_equal new_task[:sprint_id], task.sprint.id

  end

  test 'should get edit' do
    get edit_task_url(@task), xhr: true
    assert_response :success
    assert_equal 'text/javascript', @response.content_type
  end

  test 'should update task' do
    task_update = attributes_for(:task_update)
    patch task_url(@task), params: {
        task: {
            description: task_update[:description],
            hours: task_update[:hours],
            planned_hours: task_update[:planned_hours],
            rate: task_update[:rate]
        }
    },
          xhr: true
    assert_response :success
    assert_equal 'text/javascript', @response.content_type
    @task.reload
    assert_equal task_update[:description], @task.description
    assert_equal task_update[:hours].to_f, @task.hours.to_f
    assert_equal task_update[:planned_hours].to_f, @task.planned_hours.to_f
    assert_equal task_update[:rate].to_f, @task.rate.to_f
  end

  test 'should set task to deleted status' do
    refute @task.deleted

    delete task_url(@task), xhr: true
    assert_response :success
    assert_equal 'text/javascript', @response.content_type

    @task.reload
    assert @task.deleted
  end

  test 'should complete task' do
    task = create(:task, complete: false)
    get complete_task_path(task), xhr: true
    assert_response :success
    task.reload
    assert task.complete
  end

  test 'should uncomplete task' do
    task = create(:task, complete: true)
    get uncomplete_task_path(task), xhr: true
    assert_response :success
    task.reload
    refute task.complete
  end

  test 'set current task' do
    project = create(:project)
    sprint = project.current_sprint
    task = sprint.tasks.first
    get set_current_task_path(task), xhr: true
    assert_response :success
    task.reload
    assert task.current?
  end

  test 'should cancel task update' do
    get cancel_task_update_path(@task.sprint), xhr: true
    assert_response :success
  end
end
