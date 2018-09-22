require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test 'get_account' do
    user = create :user
    assert_equal user, User.get_account(user.email)
  end

  test 'account_exists(email) returns true' do
    user = create :user
    assert_equal true, User.account_exists?(user.email)
  end

  test 'account_exists(email) returns false' do
    email = 'account_does_not_exist@example.com'
    assert_equal false, User.account_exists?(email)
  end

  test 'full_name' do
    user = create(:user, first_name: 'firstname', last_name: 'lastname', email: 'full_name_email@gmail.com')
    expected = 'firstname lastname'
    assert_equal expected, user.full_name
  end

  test 'first_last_name_email' do
    user = create(:user, first_name: 'firstname', last_name: 'lastname', email: 'firstname_lastname_email@example.com')
    expected = 'firstname lastname - firstname_lastname_email@example.com'
    assert_equal expected, user.first_last_name_email
  end

  test 'github_connected? false' do
    user = create(:user, oauth: nil)
    refute user.github_connected?
  end

  test 'github_connected? false' do
    user = create(:user, oauth: '')
    refute user.github_connected
  end

  test 'github_connected? true' do
    user = create(:user, oauth: 'github_oauth_123')
    assert_equal true, user.github_connected
  end

  test 'invitations' do
    user = create(:user)
    project1 = create(:project)
    project2 = create(:project)
    project3 = create(:project)
    invitation1 = create(:invitation, email: user.email, project: project1, user_type: 'customer')
    invitation2 = create(:invitation, email: user.email, project: project2, user_type: 'customer')
    invitation3 = create(:invitation, email: user.email, project: project3, user_type: 'customer')
    assert_includes user.invitations, invitation1
    assert_includes user.invitations, invitation2
    assert_includes user.invitations, invitation3
    assert_equal 3, user.invitations.count
  end

  test 'account_exists(email) returns false' do
    assert_equal User.account_exists?('account_does_not_exist@example.com'), false
  end

  test 'returns the correct roles' do
    owner = create :user
    customer = create :user
    developer = create :user
    project = create :project, owner: owner
    project.project_developers.create(user: developer)
    project.project_customers.create(user: customer)

    assert_includes(project.developers, developer)
    assert_includes(project.customers, customer)
    assert_equal project.owner, owner

    assert_equal :customer, customer.role(project)
    assert_equal :developer, developer.role(project)
  end

  test 'valid users' do
    assert create(:user).valid?
    assert create(:valid_user).valid?
  end

  test 'github_installed? method' do
    installed_user = create(:user, oauth: '1245')
    not_installed_user = create(:user)
    assert installed_user.github_installed?
    refute not_installed_user.github_installed?
  end
end
