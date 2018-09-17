require 'test_helper'

class InvitationTest < ActiveSupport::TestCase

  test 'user returns the user' do
    user = create :user
    project = create :project
    invitation = create(:invitation, email: user.email, project: project, user_type: 'customer')
    assert_equal user, invitation.user
  end

  test 'user returns false' do
    project = create :project
    invitation = create(:invitation, email: 'does_not_exist@example.com', project: project, user_type: 'customer')
    assert_equal false, invitation.user
  end

  test 'accept! does nothing' do
    project = create :project
    invitation = create(:invitation, email: 'does_not_exist@example.com', project: project, user_type: 'customer')
    # 'Project.last.customers(:reload).size'
    assert_difference('ProjectCustomer.count', 0) do
      invitation.accept!
    end
  end

  test 'accept! a project_customer' do
    user = create :user
    project = create :project
    invitation = create(:invitation, email: user.email, project: project, user_type: 'customer')
    # 'Project.last.customers(:reload).size'
    assert_difference(['ProjectCustomer.count']) do
      invitation.accept!
    end
    assert_equal user, project.customers.last
  end

  test 'accept! a project_developer' do
    user = create :user
    project = create :project
    invitation = create(:invitation, email: user.email, project: project, user_type: 'developer')
    # 'Project.last.customers(:reload).size'
    assert_difference(['ProjectDeveloper.count']) do
      invitation.accept!
    end
    assert_equal user, project.developers.last
  end

  test 'decline' do
    user = create :user
    project = create :project
    invitation = create(:invitation, email: user.email, project: project, user_type: 'customer')
    assert_difference('Invitation.count', -1) do
      invitation.decline!
    end
  end

end