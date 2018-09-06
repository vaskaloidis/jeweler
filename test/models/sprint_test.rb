require 'test_helper'

class SprintTest < ActiveSupport::TestCase
  should belong_to(:project)
  should have_many(:tasks)

  test 'Valid Sprint is Built' do
    sprint = build(:sprint)
    assert sprint.valid?
  end

  test 'Valid Sprint and Tasks are Created' do
    sprint = create(:sprint)
    assert sprint and sprint.valid?
    regular_sprint = create(:sprint)
    assert regular_sprint and regular_sprint.valid?

    project = sprint.project
    assert project and project.valid?

    refute sprint.tasks.empty?
    task = sprint.tasks.first
    assert task and task.valid?
  end

  test 'is just an estimate' do
    sprint = create(:sprint)
    create_list(:planned_task, 5, sprint: sprint)
    sprint.reload
    assert sprint.estimate?
  end

  test 'is not an estimate' do
    sprint = create(:sprint_with_reported_hours)
    create_list(:task, 5, sprint: sprint, hours: Random.rand(1...20))
    sprint.reload
    refute sprint.estimate?
  end

  test 'only finds active tasks' do
    project = create(:project_only)
    create_list(:task, 3, sprint: project.current_sprint, deleted: false)
    create_list(:task, 3, sprint: project.current_sprint, deleted: true)
    project.reload
    assert_equal project.current_sprint.tasks.count, 3
  end

end
