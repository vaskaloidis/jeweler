require 'test_helper'

class TaskTest < ActiveSupport::TestCase

  test 'tasks without users are not valid' do
    owner = create :user
    project = create :project, owner: owner, sprint_total: 7, sprint_current: 2
    task = project.get_sprint(4).tasks.create(description: 'task has owner as the user', rate: 13)

    assert_equal task.valid?, false
  end

  test 'Valid Task is Built' do
    project = create(:project, :seed_tasks_notes, :seed_customer)
    task = build(:task, sprint: project.current_sprint)
    assert task.valid?
  end

  test 'Valid Task is Created' do
    project = create(:project, :seed_tasks_notes, :seed_customer)
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