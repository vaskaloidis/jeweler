require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test 'valid slim user' do
    assert build(:user).valid?
  end

  test 'valid fat user' do
    assert build(:valid_user).valid?
  end

  test 'invalid without name' do
    user = build(:invalid_name_user)
    refute user.valid?, 'user is valid without a name'
    assert_not_nil user.errors[:first_name], 'we are not getting an error about the first_name missing'
  end

  test 'invalid without email' do
    user = build(:invalid_email_user)
    refute user.valid?
    assert_not_nil user.errors[:email]
  end
end
