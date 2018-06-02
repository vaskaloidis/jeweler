# frozen_string_literal: true

class ProjectCustomersController < ApplicationController
  before_action :set_project, only: %i[verify_owner leave remove]
  before_action :set_project, only: %i[verify_owner index leave remove]
  before_action :verify_owner, only: [:remove]

  # Action for Customer to leave a Project
  def leave
    @project.customers.delete(@user)
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'You have left the project.' }
      format.json { head :no_content }
    end
  end

  # Owners can use this to remove (destroy) customers from Projects
  def remove
    @project.customers.delete(@user)
    respond_to do |format|
      format.js
      format.json { head :no_content }
    end
  end

  def index; end

  private

  def verify_owner
    return if @project.owner?(current_user) # TODO: Fix current_user in future for API calls
    flash[:error] = 'You must be the owner to modify project or add / update / delete project customer(s)'
    redirect_to projects_url # halts request cycle
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
