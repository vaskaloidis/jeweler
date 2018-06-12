require 'test_helper'

class UserTest < ActiveSupport::TestCase

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
