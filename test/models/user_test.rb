require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test 'returns the correct roles' do
    owner = create :user
    customer = create :user
    developer = create :user
    project = create :project, owner: owner
    project.developers.create(user: developer)
    project.customers.create(user: customer)

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
