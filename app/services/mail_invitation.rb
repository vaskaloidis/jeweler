# Sends the Email an invitation to join the Project
class AcceptInvitation < Jeweler::Service

  def initialize(project, email)
    @project = project
    @email = email
  end

  def call
    UserInviteMailer.with(email: @email, project: @project.id).invite_user.deliver_now
  end

end
