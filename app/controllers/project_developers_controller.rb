class ProjectDevelopersController < ApplicationController
  before_action :set_project
  before_action :set_user, only: %i[remove]
  respond_to :js, only: %i[remove]

  def leave
    @user = current_user
    @project.developers.delete(@user)
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'You have left the project.' }
    end
  end

  def remove
    @project.developers.delete(@user)
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

end
