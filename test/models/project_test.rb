require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  should have_many(:sprints)

  test 'build a valid project' do
    assert build(:project).valid?
  end

  test 'create a valid project' do
    assert create(:project).valid?
  end

  test 'create a valid project with sprints and tasks' do
    project = create(:project_with_sprints)
    assert project and project.valid?

    sprints = project.sprints
    assert sprints and sprints.first.valid?
    refute project.sprints.empty?

    tasks = sprints.first.tasks
    assert tasks and tasks.first.valid?
    refute tasks.empty?
  end

  test 'current_sprint method' do
    project = create(:project_with_sprints)
    current_sprint = project.sprint_current
    total_sprints = project.sprint_total
    refute current_sprint.nil? or total_sprints.nil?

    refute project.get_sprint(current_sprint).nil?
  end


end