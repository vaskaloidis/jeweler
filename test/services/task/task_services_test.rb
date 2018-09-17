require 'test_helper'

class TaskServicesTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @project = create(:project, :seed_tasks_notes, :seed_project_users)
    @user = @project.owner
    sign_in @user
  end

  test 'DestroyTask' do
    task = create(:task, deleted: false)
    DestroyTask.call(task)
    task.reload
    assert task.deleted
  end

  test 'CompleteTask' do
    task = create(:task, complete: false)
    service = CompleteTask.call(task)
    task.reload
    assert task.complete
    assert service.errors.empty?
  end

  test 'UncompleteTask' do
    task = create(:task, complete: true)
    UnCompleteTask.call(task)
    task.reload
    refute task.complete
  end

  test 'SetCurrentTask' do
    project = create(:project, :seed_tasks_notes, :seed_project_users)
    sprint = project.current_sprint
    task = sprint.tasks.first
    SetCurrentTask.call(task)
    task.reload
    assert task.current?
  end

end