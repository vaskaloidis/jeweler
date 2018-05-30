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

    project = sprint.project
    assert project and project.valid?

    refute sprint.tasks.empty?
    task = sprint.tasks.first
    assert task and task.valid?
  end

  test 'sprint sequences are getting set in order' do
    # sprints = create_list(:sprint, 5)
    project = create(:project_with_sprints)
    sprints = project.sprints
    sprints.each_with_index do |s, count|
      puts 'Sprint: ' + s.sprint.to_s
      assert s.sprint == count
    end
  end

end
