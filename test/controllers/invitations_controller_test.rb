require 'test_helper'

class InvitationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def stub_mailer
    mailer = mock('mailer')
    UserInviteMailer.stubs(:with).returns(mailer)
    # mailer.stubs(:invite_user => deliverable, :invite_customer => deliverable, :invite_developer => deliverable)
    mailer
  end

  def deliverable
    deliverable = mock('deliverable')
    deliverable.stubs(:deliver_now)
    deliverable
  end

  setup do
    @invitation = create(:invitation)
    @project = @invitation.project
    sign_in @project.owner
  end

  test "should create invitation to non-existing user" do
    project = create(:project)
    email = 'invited@gfake.com'
    stub_mailer.expects(:invite_user).returns(deliverable)
    assert_difference('Invitation.count') do
      post project_invitations_url(project), params: {user_type: 'customer', email: email}, xhr: true
    end
    assert_response :success
  end

  test "should create customer invitation to existing user" do
    project = create(:project)
    customer = create(:user)
    stub_mailer.expects(:invite_customer).returns(deliverable)
    assert_difference('Invitation.count') do
      post project_invitations_url(project), params: {user_type: 'customer', email: customer.email}, xhr: true
    end
    assert_response :success
  end

  test "should create developer invitation to existing user" do
    project = create(:project)
    developer = create(:user)
    stub_mailer.expects(:invite_developer).returns(deliverable)
    assert_difference('Invitation.count') do
      post project_invitations_url(project), params: {user_type: 'developer', email: developer.email}, xhr: true
    end
    assert_response :success
  end

  test "should get accept" do
    get accept_invitation_url(@invitation)
    assert_redirected_to root_path
    # assert_equal 'You have joined the project ' + @project.name, flash[:notice]
  end

  test "should get decline" do
    get decline_invitation_url(@invitation)
    assert_redirected_to root_path
    # assert_equal 'You have joined the project ' + @project.name, flash[:notice]
  end

  test "should destroy invitation" do
    assert_difference('Invitation.count', -1) do
      delete destroy_invitation_url(@invitation), xhr: true
    end
    assert_response :success
  end
end
