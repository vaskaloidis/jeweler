require 'test_helper'

class InvitationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @invitation = create(:invitation)
    @project = @invitation.project
    sign_in @project.owner
  end

  test "should create invitation" do
    project = create(:project, :seed_tasks_notes, :seed_customer)
    assert_difference('Invitation.count') do
      post project_invitations_url(project), params: { project_customer: { email: 'invited@gfake.com' } }, xhr: true
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
