require 'test_helper'

class TaskTest < ActiveSupport::TestCase

  test 'created_by and assigned_to relationships all work' do
    dev1 = create(:user)
    dev2 = create(:user)
    project = create(:project)
    sprint = project.get_sprint(2)
    task = Tasks.create(sprint: sprint, created_by: dev1, assigned_to: dev2)

    assert_equal task.created_by, dev1
    assert_equal task.assigned_to, dev2
  end

  test 'add_developer' do
    dev = create(:user)
    project = create(:project, :seed_owner)
    project.add_developer(dev)
    assert_includes project.developers, dev1
  end

  test 'add_customer' do
    dev = create(:user)
    project = create(:project)
    project.add_customer(dev)
    assert_includes project.customers, dev
  end
  test 'add_customer' do
    customer = create(:user)
    developer = create(:user)
    project = create(:project)
    project.add_customer(customer)
    project.add_developer(developer)
    assert_true project.customer?(customer)
    assert_false project.customer?(developer)
  end


  test 'tasks without users are not valid' do
    owner = create :user
    project = create :project, owner: owner, sprint_total: 7, sprint_current: 2
    task = project.get_sprint(4).tasks.create(description: 'task has owner as the user', rate: 13)

    assert_equal task.valid?, false
  end

  test 'Valid Task is Built' do
    project = create(:project, :seed_tasks_notes, :seed_project_users)
    task = build(:task, sprint: project.current_sprint)
    assert task.valid?
  end

  test 'Valid Task is Created' do
    project = create(:project, :seed_tasks_notes, :seed_project_users)
    task = create(:task, sprint: project.current_sprint)
    assert task.valid?
  end

  test 'Task has a valid Sprint' do
    task = create(:task)
    sprint = task.sprint
    assert sprint and sprint.valid?

    project = sprint.project
    assert project and project.valid?
  end
end