class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy, :users, :settings]
  respond_to :html, :js, only: [:request_payment, :users]
  respond_to :html, only: [:settings]

  def settings; end

  def users; end

  def commit_codes_modal # TODO: Please god remove this
    respond_to do |format|
      format.js
    end
  end

  def index
    @owner_projects = current_user.owner_projects
    @customer_projects = current_user.customer_projects
    @developer_projects = current_user.developer_projects
  end

  def show
    @notes = @project.notes.where(note_type: [:note, :commit, :project_update]).order('created_at DESC').all
  end

  def new
    @project = Project.new
  end

  def edit; end

  def create
    @project = current_user.owner_projects.create(project_params)
    respond_to do |format|
      if @project.save
        # sync_github(@project, current_user) # TODO: Sync GitHub Commits eventually
        format.html {redirect_to @project, notice: 'Project was successfully created.'}
        format.json {render :show, status: :created, location: @project}
      else
        format.html {render :new}
        format.json {render json: @project.errors, status: :unprocessable_entity}
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html {redirect_to @project, notice: 'Project was successfully updated.'}
        format.json {render :show, status: :ok, location: @project}
      else
        format.html {render :edit}
        format.json {render json: @project.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @project.destroy!
    respond_to do |format|
      format.html {redirect_to projects_url, notice: 'Project was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :language, :image, :sprint_total,
                                    :sprint_current, :description, :github_repo_id,
                                    :heroku_token, :github_branch, :github_webhook_id,
                                    :readme_file, :readme_remote, :stage_website_url, :demo_url,
                                    :prod_url, :complete, :task_id, :google_analytics_tracking_code)
  end
end
