require "application_system_test_case"

class UsersAuthTest < ApplicationSystemTestCase
  test "visiting the unauthenticated home" do
    visit root_path
    assert_selector "h2", text: "CUSTOMER RELATIONSHIP MANAGEMENT"
  end

  test "register a new user" do
    visit root_path
    click_on "Register"
    assert_selector "h3", text: "Sign Up"

    user = create(:user)
    user.save
    fill_in('Email', with: user.email)
    fill_in('Password', with: user.password)
    fill_in('user_password_confirmation', with: user.password_confirmation)
    fill_in('First Name', with: user.first_name)
    fill_in('Last Name', with: user.last_name)
    click_on "registration_submit_btn"

    users = User.where(email: user.email)
    refute users.empty?
    user = users.first
    user.confirm
    user.save
    assert user.valid?
  end

  test "login a new user" do
    user = create(:user)
    user.confirm
    user.save
    visit root_path
    click_on "Login"
    assert_selector "h3", text: "Login"

    assert login_user(user.email, user.password)
  end

  def login_user(email, password)
    fill_in('user_email', with: email)
    fill_in('Password', with: password)
    click_on "login_submit_btn"
    user = User.where(email: email).first
    return assert_text "Welcome " + user.full_name + "."
  end

  def open_signup_email(email)
    clear_emails
    visit email_trigger_path
    # Will find an email sent to `test@example.com`
    # and set `current_email`
    open_email(email)
    current_email.click_link 'your profile'
    expect(page).to have_content 'Profile page'
  end

end
