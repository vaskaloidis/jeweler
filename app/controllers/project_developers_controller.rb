class ProjectDevelopersController < ApplicationController
  before_action :set_project_developer, only: [:show, :edit, :update, :destroy]
  before_action :set_project, only: [:index, :create, :new]
  before_action :set_user, only: %i[verify_owner leave remove]
  before_action :set_project, only: %i[verify_owner index leave remove]
  before_action :verify_owner, only: [:remove]
  respond_to :js, only: %i[remove]

  def leave
    @project.developers.delete(@user)
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'You have left the project.' }
    end
  end

  def remove
    @project.developers.delete(@user)
  end

  private

  # TODO: Replace with authorization policy system
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
