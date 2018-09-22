class ProjectsController < ApplicationController
  before_action :set_project, only: [:verify_owner, :show, :edit, :update, :destroy, :users]
  # before_action :verify_sprints_exist, only: [:show, :edit, :update, :create]
  respond_to :html, :js, only: [:request_payment, :users]
  respond_to :html, only: [:settings]
  def settings

  end

  def users; end

  def commit_codes_modal
    respond_to do |format|
      format.js
    end
  end

  # GET /projects
  # GET /projects.json
  def index
    @owner_projects = current_user.owner_projects
    @customer_projects = current_user.customer_projects
    @developer_projects = current_user.developer_projects
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    # redcarpet = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    # @github_readme_parsed = redcarpet.render(readme_raw)

    @notes = @project.notes.where(note_type: [:note, :commit, :project_update]).order('created_at DESC').all
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit;
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = current_user.owner_projects.create(project_params)
    respond_to do |format|
      if @project.save
        if @project.valid?
          sync_github(@project, current_user)
        end
        format.html {redirect_to @project, notice: 'Project was successfully created.'}
        format.json {render :show, status: :created, location: @project}
      else
        format.html {render :new}
        format.json {render json: @project.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update

    respond_to do |format|
      if @project.update(project_params)

        if @project.valid?
          sync_github(@project, current_user)
        end

        format.html {redirect_to @project, notice: 'Project was successfully updated.'}
        format.json {render :show, status: :ok, location: @project}
      else
        format.html {render :edit}
        format.json {render json: @project.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html {redirect_to projects_url, notice: 'Project was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  def verify_owner
    unless @project.owner?(current_user)
      flash[:error] = 'You must be the owner to modify project'
      redirect_to projects_url # halts request cycle
    end
  end

  def verify_customer
    unless @project.customer?(current_user) or @project.owner?(current_user)
      flash[:error] = 'You must be a member of this project to view it'
      redirect_to projects_url # halts request cycle
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :language, :image, :sprint_total,
                                    :sprint_current, :description, :github_repo,
                                    :heroku_token, :github_branch,
                                    :readme_file, :readme_remote, :stage_website_url, :demo_url,
                                    :prod_url, :complete, :task_id, :google_analytics_tracking_code)
  end
end
