# frozen_string_literal: true

class InvitationsController < ApplicationController
  before_action :set_invitation, only: %i[destroy accept decline]

  def create
    @email = params[:email]
    @project = Project.find(params[:project_id])

    # Check if User is already a member of this project
    if @project.customer? @email
      @already_customer = true
    else
      @already_customer = false
      # Check if Invitation exists already
      if @project.invitations.where(email: @email).empty?
        @invitation_exists = false

        @invitation = @project.invitations.create(email: @email)

        if User.account_exists? @email
          # TODO: Implement Mailer with delayed job
          UserInviteMailer.with(email: @email, project: @project.id).invite_user.deliver_now
          @user_invited = true
        else
          @user_invited = false
        end
        @project.invitations.reload
      else
        @invitation_exists = true
      end
    end

    respond_to do |format|
      format.js
      if @invitation.valid?
        format.json { render :show, status: :created, location: @project_customer }
      else
        format.json { render json: @project_customer.errors, status: :unprocessable_entity }
      end
    end
  end

  def accept
    pc = @project.customers.create(@user)

    if pc.valid?
      @invitation.destroy
    else
      @errors << 'Invitation Accept Error: Valid Project Customer could not be created.'
    end

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'You have joined the project ' + @project.name }
    end
  end

  # TODO: This is the same as destroy, can we remove it or one or make it an alias
  def decline
    destroy = @invitation.destroy
    @errors << 'Decline Invitation Error: destroying invitation.' unless destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'You have declined the project invitation.' }
    end
  end

  def destroy
    destroy = @invitation.destroy
    @errors << 'Error destroying invitation.' unless destroy
    respond_to do |format|
      format.json { head :no_content }
      format.js
    end
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
