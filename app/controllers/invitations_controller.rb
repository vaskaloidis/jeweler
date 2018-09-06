# frozen_string_literal: true

class InvitationsController < ApplicationController
  before_action :set_invitation, only: %i[destroy accept decline]
  respond_to :js, only: [:create, :destroy]

  def create
    @email = params[:email]
    @project = Project.find(params[:project_id])
    @user_type = params[:user_type]

    # Check if User is already a member of this project
    if @project.customers.include? @email
      @errors << "#{@email} is already a project customer"
    elsif @project.developers.include? @email
      @errors << "#{@email} is already a project developer"
    elsif @project.owner.email == @email
      @errors << 'You cannot invite the project Owner'
    else
      # Check if Invitation exists already
      if @project.invitations.where(email: @email).empty?
        @invitation = @project.invitations.create(email: @email, user_type: @user_type)
        @errors << 'Error creating invitation' if @invitation.invalid?

        if User.account_exists? @email
          if @user_type == 'customer'
            UserInviteMailer.with(email: @email, project: @project.id).invite_customer.deliver_now
          else
            UserInviteMailer.with(email: @email, project: @project.id).invite_developer.deliver_now
          end
          @notifications << "#{@email} was sent an invitation to join this project."
        else
          @notifications << "#{@email} was sent an invitation to join Jeweler + this project."
          UserInviteMailer.with(email: @email, project: @project.id).invite_user.deliver_now
        end
      else
        @errors << "#{@email} is already invited to the project"
      end
    end
  end

  def accept
    @invitation.accept!
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'You have joined the project ' + @project.name }
    end
  end

  # TODO: This is the same as destroy, can we remove it or one or make it an alias
  def decline
    destroy = @invitation.decline!
    @errors << 'Decline Invitation Error: destroying invitation.' unless destroy
    respond_to do |format|
      format.html {redirect_to root_path, notice: 'You have declined the project invitation.'}
    end
  end

  def destroy
    destroy = @invitation.destroy
    @errors << 'Error destroying invitation.' unless destroy
  end

  private

  def set_invitation
    @invitation = Invitation.find(params[:id])
    @project = @invitation.project
    @email = @invitation.email
    @user = User.where(email: @email).first
  end

  def invitation_params
    params.require(:invitation).permit(:email, :project_id)
  end
end
