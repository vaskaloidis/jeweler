require 'test_helper'

class EventTest < ActiveSupport::TestCase

  test 'project.events.create :invitation_sent' do
    user = create :user
    project = create :project, owner: user
    invitation = project.invitations.create email: user.email, user_type: 'developer'
    event = invitation.events.create! subject: 'invitation_sent', user: user

    assert event.valid?
    assert_equal user, event.user
    assert_equal "#{invitation.email} was sent an invitation to join the project as a #{invitation.user_type}", event.details
    assert_equal 'invitation_sent', event.subject
    assert_equal invitation.id, event.eventable.id
  end

end
