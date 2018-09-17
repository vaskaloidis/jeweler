require 'test_helper'

class CreateTaskTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers


  test 'validate_assigned_to returns true for the owner' do
    owner = create(:user)
    project = create(:project, :seed_tasks_notes, owner: owner)
    sprint = project.current_sprint
    service = CreateTask.call({sprint: sprint, created_by_id: owner.id, assigned_to_id: owner.id, description: 'task-desc', hours: 5.0, planned_hours: 3.0, rate: 25.0})
    # assert service.result.valid?
    assert_not_includes service.errors, 'Must only be assigned to the Project Owner or Developer.'
  end

  test 'validate_assigned_to returns true for a developer' do
    owner = create(:user)
    developer = create(:user)
    project = create(:project, :seed_tasks_notes, owner: owner)
    project.add_developer(developer)
    sprint = project.current_sprint
    expectation = { sprint_id: sprint.id, created_by: owner, assigned_to: developer, description: 'task-desc', hours: 5.0, planned_hours: 3.0, rate: 25.0 }
    service = CreateTask.call(expectation)

    assert service.result.valid?
    assert_not_includes service.errors, 'Error Creating task: Assigned to must be the Project Owner or a Developer.'
    assert_not_includes service.errors, 'Error Creating task: Created by must be the Project Owner or a Developer.'
    task = service.result
    assert_equal owner.id, task.created_by.id
    assert_equal sprint.id, task.sprint.id
    assert_equal developer.id, task.assigned_to.id
    assert_equal expectation[:description], task.description
    assert_equal expectation[:hours], task.hours
    assert_equal expectation[:planned_hours], task.planned_hours
    assert_equal expectation[:rate], task.rate
  end

  test 'validate_assigned_to returns false for a customer' do
    owner = create(:user)
    customer = create(:user)
    project = create(:project, :seed_tasks_notes, owner: owner)
    project.add_customer(customer)
    sprint = project.current_sprint
    service = CreateTask.call({sprint: sprint, created_by_id: owner.id, assigned_to_id: customer.id, description: 'task-desc', hours: 5.0, planned_hours: 3.0, rate: 25.0})

    refute service.result.valid?
    assert_includes service.errors, 'Error Creating task: Assigned to must be the Project Owner or a Developer.'
    assert_not_includes service.errors, 'Error Creating task: Created by must be the Project Owner or a Developer.'
  end

  test 'validate_created_by cannot be nil' do
    owner = create(:user)
    project = create(:project, :seed_tasks_notes, owner: owner)
    sprint = project.current_sprint
    service = CreateTask.call({sprint: sprint, description: 'task-desc', hours: 5.0, planned_hours: 3.0, rate: 25.0})

    refute service.result.valid?
    assert_includes service.errors, 'Error Creating task: Created by cannot be nil.'
  end

  test 'validate_created_by returns false for a customer' do
    owner = create(:user)
    customer = create(:user)
    project = create(:project, :seed_tasks_notes, owner: owner)
    project.add_customer(customer)
    sprint = project.current_sprint
    service = CreateTask.call({sprint: sprint, created_by_id: customer.id, description: 'task-desc', hours: 5.0, planned_hours: 3.0, rate: 25.0})

    refute service.result.valid?
    assert_includes service.errors, 'Error Creating task: Created by must be the Project Owner or a Developer.'
  end

  test 'validate_created_by returns true for owner' do
    owner = create(:user)
    project = create(:project, :seed_tasks_notes, owner: owner)
    sprint = project.current_sprint
    service = CreateTask.call({sprint: sprint, created_by_id: owner.id, description: 'task-desc', hours: 5.0, planned_hours: 3.0, rate: 25.0})
    assert service.result.valid?
    assert_not_includes service.errors, 'Error Creating task: Created by must be the Project Owner or a Developer.'
  end

  test 'validate_created_by returns true for developer' do
    owner = create(:user)
    developer = create(:user)
    project = create(:project, :seed_tasks_notes, owner: owner)
    project.add_developer(developer)
    sprint = project.current_sprint
    service = CreateTask.call({sprint: sprint, created_by_id: developer.id, description: 'task-desc', hours: 5.0, planned_hours: 3.0, rate: 25.0})
    assert service.result.valid?
    assert_not_includes service.errors, 'Error Creating task: Created by must be the Project Owner or a Developer.'
  end

end