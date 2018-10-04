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

  test 'payment_requests' do
    skip 'not finished yet'
  end

  test 'payment_requested?' do
    skip 'not finished yet'
  end

  test 'add_developer' do
    dev1 = create(:user)
    dev2 = create(:user)
    project = create(:project, :seed_owner)
    project.add_developer(dev1).add_developer(dev2)
    assert_includes project.developers, dev1
    assert_includes project.developers, dev2
  end

  test 'add_customer' do
    customer1 = create(:user)
    customer2 = create(:user)
    project = create(:project)
    project.add_customer(customer1).add_customer(customer2)
    assert_includes project.customers, customer2
    assert_includes project.customers, customer1
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

  test 'only finds active tasks' do
    project = create(:project_only)
    create_list(:task, 3, sprint: project.current_sprint, deleted: false)
    create_list(:task, 3, sprint: project.current_sprint, deleted: true)
    project.reload
    assert_equal project.tasks.count, 3
  end

  test '#github returns new GitHubRepo object' do
    ghr = mock('GitHubRepo')
    GitHubRepo.stubs(:new).returns(ghr)
    owner = create(:user)
    project = create(:project, owner: owner)
    assert_equal ghr, project.github
  end

  test 'get_sprint' do
    skip 'not sure how to test yet'
    project = create(:project, sprint_total: 8, sprint_current: 3)
  end

  test 'sprint_notes' do
    skip 'not sure how to test yet'
  end

  test 'current_sprint=' do
    project = create(:project, sprint_total: 8, sprint_current: 3)
    new_sprint = project.get_sprint(4)
    project.current_sprint = new_sprint
    assert_equal 4, project.sprint_current
  end

  test 'users' do
    owner = create :user
    customer1 = create :user
    customer2 = create :user
    developer1 = create :user
    project = create :project, owner: owner
    project.add_customer(customer1).add_customer(customer2).add_developer(developer1)
    assert_includes project.customers, customer1
    assert_includes project.customers, customer2
    assert_includes project.developers, developer1
  end

end