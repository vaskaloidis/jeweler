require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  should have_many(:sprints)
  should have_many(:customers)
  should have_many(:project_customers)
  should have_many(:developers)
  should have_many(:project_developers)

  test 'owner? is true' do
    owner = create(:user)
    project = create(:project, owner: owner)
    assert_equal true, project.owner?(owner)
  end

  test 'current_sprint=' do
    project = create(:project, sprint_total: 8, sprint_current: 3)
    new_sprint = project.get_sprint(4)
    project.current_sprint = new_sprint
    assert_equal 4, project.sprint_current
  end

  test 'payment_requests' do
    skip 'not finished yet'
  end

  test 'payment_requested?' do
    skip 'not finished yet'
  end

  test 'add_developer' do
    dev = create(:user)
    project = create(:project, :seed_owner)
    project.add_developer(dev)
    assert_includes project.developers, dev
  end

  test 'add_customer' do
    customer = create(:user)
    project = create(:project)
    project.add_customer(customer)
    assert_includes project.customers, customer
  end

  test 'customer?' do
    customer = create(:user)
    developer = create(:user)
    project = create(:project)
    project.add_customer(customer)
    project.add_developer(developer)
    assert_equal true, project.customer?(customer)
    assert_equal false, project.customer?(developer)
  end

  # TODO: Remove
  test 'factory generates relationships correctly' do
    project = create :project, :seed_tasks_notes
    assert project and project.valid?

    sprints = project.sprints
    assert sprints and sprints.first.valid?
    refute project.sprints.empty?

    tasks = sprints.first.tasks
    assert tasks and tasks.first.valid?
    refute tasks.empty?

    assert_equal project.sprint_total, 5 # Default 5 total sprints
    assert_equal project.tasks.count, 10 # 2 Task per Sprint
    assert_equal project.notes.count, 10 # 2 Note per Sprint
  end

  test 'after_save build_sprints callback' do
    project = create :project, :seed_tasks_notes

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

# TODO: Remove
  test 'only finds active tasks' do
    project = create(:project_only)
    create_list(:task, 3, sprint: project.current_sprint, deleted: false)
    create_list(:task, 3, sprint: project.current_sprint, deleted: true)
    project.reload
    assert_equal project.tasks.count, 3
  end

  test 'github_installed?' do
    installed_user = create(:user, oauth: '1245')
    installed_project = create(:project, :seed_tasks_notes, :seed_project_users, owner: installed_user)
    not_installed_user = create(:user)
    not_installed_project = create(:project, :seed_tasks_notes, :seed_project_users, owner: not_installed_user)
    assert installed_project.github.installed
    refute not_installed_project.github.installed
  end

# Skipped

  test 'get_sprint' do
    skip 'not sure how to test yet'
    project = create(:project, sprint_total: 8, sprint_current: 3)
  end

  test 'sprint_notes' do
    skip 'not sure how to test yet'
  end

end