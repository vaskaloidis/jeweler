class AcceptInvitation < Jeweler::Service

  def initialize(project, email)
    @project = project
    @email = email
  end

  def call
    result = Hash.new
    if project.customer? email # if User is already a member of this project
      result[:already_customer] = true
    else
      result[:already_customer] = false
      if project.invitations.where(email: email).empty? # if Invitation exists already
        result[:invitation_exists] = false
        invitation = project.invitations.create(email: email)
        if User.account_exists? email
          MailInvitation.call(project, email)
          result[:user_invited] = true
        else
          result[:user_invited] = false
        end
        project.invitations.reload
      else
        result[:invitation_exists] = true
      end
    end
    result[:invitation] = invitation
    result
  end

  private

  attr_reader :email, :project
end