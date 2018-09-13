require 'test_helper'

class TaskTest < ActiveSupport::TestCase

  test 'code' do
    owner = create(:user)
    developer = create(:user)
    project = create(:project, owner: owner, sprint_current: 3, sprint_total: 5)
    project.add_developer(developer)
    sprint = project.get_sprint(4)
    task = Task.create(sprint: sprint, created_by: developer, description: 'task-desc', hours: 5.0, planned_hours: 3.0, rate: 25.0)
    assert_equal 1, sprint.tasks.count
    assert_equal '#task4a', task.code
  end

  test 'created_by and assigned_to relationships work' do
    dev1 = create(:user)
    dev2 = create(:user)
    project = create(:project)
    sprint = project.get_sprint(2)
    task = Task.create(sprint: sprint, created_by: dev1, assigned_to: dev2)
    assert_equal task.created_by, dev1
    assert_equal task.assigned_to, dev2
  end

  def mock_errors
    errors_mock = mock('errors')
    errors_mock.stub(:add)
    mock
  end

  test 'validate_assigned_to returns true for the owner' do
    owner = create(:user)
    project = create(:project, :seed_tasks_notes, owner: owner)
    sprint = project.current_sprint
    task = Task.create(sprint: sprint, created_by: owner, assigned_to: owner, description: 'task-desc', hours: 5.0, planned_hours: 3.0, rate: 25.0)
    task.validate_assigned_to
    # assert_equal true, task.valid?
    assert_not_includes task.errors, 'Must only be assigned to the Project Owner or Developer.'
  end

  test 'validate_assigned_to returns true for a developer' do
    owner = create(:user)
    developer = create(:user)
    project = create(:project, :seed_tasks_notes, owner: owner)
    project.add_customer(developer)
    sprint = project.current_sprint
    task = Task.create(sprint: sprint, created_by: owner, assigned_to: developer, description: 'task-desc', hours: 5.0, planned_hours: 3.0, rate: 25.0)
    task.validate_assigned_to
    assert_equal true, task.valid?
    assert_not_includes task.errors, 'Must only be assigned to the Project Owner or Developer.'
  end

  test 'validate_assigned_to returns false for a customer' do
    owner = create(:user)
    customer = create(:user)
    project = create(:project, :seed_tasks_notes, owner: owner)
    project.add_customer(customer)
    sprint = project.current_sprint
    task = Task.create(sprint: sprint, created_by: owner, assigned_to: customer, description: 'task-desc', hours: 5.0, planned_hours: 3.0, rate: 25.0)
    task.validate_assigned_to
    assert_equal false, task.valid?
    assert_includes task.errors, 'Must only be assigned to the Project Owner or Developer.'
  end

  test 'validate_assigned_to returns false for a non-project user' do
    owner = create(:user)
    non_project_user = create(:user)
    project = create(:project, :seed_tasks_notes, owner: owner)
    sprint = project.current_sprint
    task = Task.create(sprint: sprint, created_by: owner, assigned_to: non_project_user, description: 'task-desc', hours: 5.0, planned_hours: 3.0, rate: 25.0)
    task.validate_assigned_to
    assert_equal true, task.valid?
    assert_not_includes task.errors, 'Must only be assigned to the Project Owner or Developer.'
  end

  test 'validate_created_by cannot be nil' do
    owner = create(:user)
    project = create(:project, :seed_tasks_notes, owner: owner)
    sprint = project.current_sprint
    task = Task.create(sprint: sprint, description: 'task-desc', hours: 5.0, planned_hours: 3.0, rate: 25.0)
    task.validate_created_by
    assert_equal false, task.valid?
    assert_includes task.errors, 'Must have created_by assigned.'
  end

  test 'validate_created_by returns false for a customer' do
    owner = create(:user)
    non_project_user = create(:user)
    project = create(:project, :seed_tasks_notes, owner: owner)
    sprint = project.current_sprint
    task = Task.create(sprint: sprint, created_by: non_project_user, description: 'task-desc', hours: 5.0, planned_hours: 3.0, rate: 25.0)
    task.validate_created_by
    assert_equal false, task.valid?
    assert_includes task.errors, 'Must be created by the Project Owner or Developer'
  end

  test 'validate_created_by returns false for a customer' do
    owner = create(:user)
    customer = create(:user)
    project = create(:project, :seed_tasks_notes, owner: owner)
    project.add_customer(user)
    sprint = project.current_sprint
    task = Task.create(sprint: sprint, created_by: customer, description: 'task-desc', hours: 5.0, planned_hours: 3.0, rate: 25.0)
    task.validate_created_by
    assert_equal false, task.valid?
    assert_includes task.errors, 'Must be created by the Project Owner or Developer'
  end

  test 'validate_created_by returns true for owner' do
    owner = create(:user)
    project = create(:project, :seed_tasks_notes, owner: owner)
    sprint = project.current_sprint
    task = Task.create(sprint: sprint, created_by: owner, description: 'task-desc', hours: 5.0, planned_hours: 3.0, rate: 25.0)
    task.validate_created_by
    assert_equal true, task.valid?
    assert_not_includes task.errors, 'Must be created by the Project Owner or Developer'
    assert_includes task.errors, 'Must have created_by assigned.'
  end

  test 'validate_created_by returns true for developer' do
    owner = create(:user)
    developer = create(:user)
    project = create(:project, :seed_tasks_notes, owner: owner)
    project.add_developer(developer)
    sprint = project.current_sprint
    task = Task.create(sprint: sprint, created_by: developer, description: 'task-desc', hours: 5.0, planned_hours: 3.0, rate: 25.0)
    task.validate_created_by
    assert_equal true, task.valid?
    assert_not_includes task.errors, 'Must be created by the Project Owner or Developer'
    assert_includes task.errors, 'Must have created_by assigned.'
  end

end