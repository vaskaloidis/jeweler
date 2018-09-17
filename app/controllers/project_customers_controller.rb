# frozen_string_literal: true

class ProjectCustomersController < ApplicationController
  before_action :set_project, only: %i[leave remove]
  before_action :set_user, only: %i[remove]
  respond_to :js, only: %i[remove]

  def leave
    @user = current_user
    @project.customers.delete(@user)
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'You have left the project.' }
    end
  end

  def remove
    @project.customers.delete(@user)
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
