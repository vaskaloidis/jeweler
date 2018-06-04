require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test 'valid users' do
    assert create(:user).valid?
    assert create(:valid_user).valid?
  end
end
