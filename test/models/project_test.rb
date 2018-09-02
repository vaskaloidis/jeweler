require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  should have_many(:sprints)

  setup do
    @project = create(:project, :seed_tasks_notes, :seed_customer)
  end

  test 'creates a valid project' do
    assert @project.valid?
  end

  test 'factory generates relationships correctly' do
    project = @project
    assert project and project.valid?

    sprints = project.sprints
    assert sprints and sprints.first.valid?
    refute project.sprints.empty?

    tasks = sprints.first.tasks
    assert tasks and tasks.first.valid?
    refute tasks.empty?

    assert_equal @project.sprint_total, 5 # Default 5 total sprints
    assert_equal @project.tasks.count, 10 # 2 Task per Sprint
    assert_equal @project.notes.count, 10 # 2 Note per Sprint
  end

  test 'should have a valid project owner and customers' do
    assert @project.owner.valid? && !@project.owner.nil?
    assert @project.owner.instance_of?(User)

    refute @project.customers.nil?
    @project.customers.each do |customer|
      assert customer.valid? && customer.instance_of?(User)
    end
  end

  test 'callback should build sprints correctly' do
    project = @project

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

  test 'only finds active tasks' do
    project = create(:project_only)
    create_list(:task, 3, sprint: project.current_sprint, deleted: false)
    create_list(:task, 3, sprint: project.current_sprint, deleted: true)
    project.reload
    assert_equal project.tasks.count, 3
  end

  test 'github_installed? method' do
    installed_user = create(:user, oauth: '1245')
    installed_project = create(:project, :seed_tasks_notes, :seed_customer, owner: installed_user)
    not_installed_user = create(:user)
    not_installed_project = create(:project, :seed_tasks_notes, :seed_customer, owner: not_installed_user)
    assert installed_project.github_installed?
    refute not_installed_project.github_installed?
  end

end