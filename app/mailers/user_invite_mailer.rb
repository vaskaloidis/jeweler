class UserInviteMailer < ApplicationMailer

  def invite_user(email, project_name, inviter_name)
    mail(to: email, subject: 'Invitation To Join JewlerCRM')
  end

end
