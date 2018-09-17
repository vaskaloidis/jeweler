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

end