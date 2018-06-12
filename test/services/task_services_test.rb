require 'test_helper'

class TaskServicesTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @project = create(:project)
    @user = @project.owner
    sign_in @user
  end

  test 'create task service' do
    sprint = create(:sprint)
    new_task = attributes_for(:new_task)
    new_task[:sprint_id] = sprint.id
    task_params = { task: new_task }
    assert_difference('Task.count') do
      @service_object = CreateTask.call(new_task)
    end
    so_result = @service_object.result
    assert @service_object.errors.empty?
    assert so_result.valid?
    task = Task.last
    assert_equal new_task[:description], task.description
    assert_equal new_task[:hours].to_f, task.hours.to_f
    assert_equal new_task[:planned_hours].to_f, task.planned_hours.to_f
    assert_equal new_task[:rate].to_f, task.rate.to_f
    assert_equal new_task[:sprint_id], task.sprint.id
  end


  test 'delete task service' do
    task = create(:task, deleted: false)
    DestroyTask.call(task)
    task.reload
    assert task.deleted
  end

  test 'complete task service' do
    task = create(:task, complete: false)
    CompleteTask.call(task)
    task.reload
    assert task.complete
  end

  test 'uncomplete task service' do
    task = create(:task, complete: true)
    UnCompleteTask.call(task)
    task.reload
    refute task.complete
  end

  test 'set current task service' do
    project = create(:project)
    sprint = project.current_sprint
    task = sprint.tasks.first
    SetCurrentTask.call(task)
    task.reload
    assert task.current?
  end

end