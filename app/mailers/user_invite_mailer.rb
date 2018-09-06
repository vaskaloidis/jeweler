class UserInviteMailer < ApplicationMailer

  def invite_customer
    @email = params[:email]
    @project_name = Project.find(params[:project]).name
    mail(to: @email, subject: 'Jeweler - Invitation to Join ' +@project_name)
  end

  def invite_developer
    @email = params[:email]
    @project_name = Project.find(params[:project]).name
    mail(to: @email, subject: 'Jeweler - Invitation to Join ' +@project_name)
  end

  def invite_user
    @email = params[:email]
    @project_name = Project.find(params[:project]).name
    # @email = email
    # @project_name = Project.find(project_id).name
    mail(to: @email, subject: 'Jeweler - Invitation to Join ' +@project_name)
  end

end
