require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  should have_many(:sprints)

  test 'build a valid project' do
    assert build(:project).valid?
    assert create(:project).valid?
  end

  # TODO: This is a test of the factory-tests, this does not belong here, move it
  test 'create a valid project with sprints and tasks' do
    project = create(:project)
    assert project and project.valid?

    sprints = project.sprints
    assert sprints and sprints.first.valid?
    refute project.sprints.empty?

    tasks = sprints.first.tasks
    assert tasks and tasks.first.valid?
    refute tasks.empty?
  end

  test 'callback should build sprints correctly' do
    project = create(:project)

    refute project.sprint_current.nil?
    refute project.sprint_total.nil?
    refute project.current_sprint.nil?
    refute project.get_sprint(1).nil?

    (1..project.sprint_total).each do |sprint|
      this_sprint = project.get_sprint(sprint)
      assert_equal this_sprint.sprint, sprint
      refute this_sprint.nil?
    end
  end

end