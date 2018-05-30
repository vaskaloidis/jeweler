require 'test_helper'

class TaskTest < ActiveSupport::TestCase

  test 'Valid Task is Built' do
    task = build(:task)
    assert task.valid?
  end

  test 'Valid Task is Created' do
    task = create(:task)
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