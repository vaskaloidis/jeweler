require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in create(:user)
    # @project = create(:project_with_sprints)
    # @sprint = @project.sprints.first
    # @task = @sprint.tasks.first
    @task = create(:task)
    @sprint = @task.sprint
    @project = @sprint.project
  end

  test "should get new" do
    get new_project_sprint_task_url(@project, @sprint), xhr: true

    assert_response :success
    assert_equal "text/javascript", @response.content_type
  end

  test "should create task" do
    new_task = attributes_for(:new_task)
    assert_difference('Task.count') do
      post tasks_url, params: {task: new_task}, xhr:true
    end
    assert_response :success
    assert_equal "text/javascript", @response.content_type
    latest = Task.last
    assert_equal latest.description, new_task.description

  end

  test "should get edit" do
    get edit_task_url(@task), xhr: true
    assert_response :success
    assert_equal "text/javascript", @response.content_type
  end

  test "should update task" do
    task_update = attributes_for(:task_update)
    patch task_url(@task), params: task_update, xhr: true
    assert_response :success
    assert_equal "text/javascript", @response.content_type
    assert_equal task_update[:description], @task.description
    assert_equal task_update[:hours], @task.hours
    assert_equal task_update[:planned_hours], @task.planned_hours
    assert_equal task_update[:rate], @task.rate
  end

  test "should set task to deleted status" do
    refute @task.deleted

    delete task_url(@task), xhr: true
    assert_response :success
    assert_equal "text/javascript", @response.content_type

    @task.reload
    assert @task.deleted
  end
end
