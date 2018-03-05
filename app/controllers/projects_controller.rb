class ProjectsController < ApplicationController
  before_action :set_project, only: [:verify_owner, :show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :verify_owner, only: [:edit, :update, :destroy]
  before_action :verify_owner, only: [:owner]


  # GET /projects
  # GET /projects.json
  def index
    @owner_projects = current_user.owner_projects
    @customer_projects = current_user.customer_projects
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    # require 'redcarpet'

    gh_url = @project.github_url

    if gh_url.ends_with? '/'
      gh_url = gh_url + 'master/README.md'
    else
      gh_url = gh_url + '/master/README.md'
    end

    gh_url.sub! 'github.com', 'raw.githubusercontent.com'

    readme_raw = Net::HTTP.get(URI.parse(gh_url))

    if readme_raw == 'Not Found'
      @github_readme_parsed = 'README file could not be loaded.<br>
                               GitHub README file: ' + gh_url
    else
      redcarpet = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
      @github_readme_parsed = redcarpet.render(readme_raw)
    end

    @project_customer = ProjectCustomer.new
    @project_customer.project = @project

    @note_note = Note.new
    @note_note.project = @project
    @note_note.note_type = 'note'
    @note_note.author = current_user

    @note_update = Note.new
    @note_update.project = @project
    @note_update.note_type = 'project_update'
    @note_update.author = current_user

    @note_demo = Note.new
    @note_demo.project = @project
    @note_demo.note_type = 'demo'
    @note_demo.author = current_user

  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
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
    unless @project.is_owner(current_user)
      flash[:error] = "You must be the owner to modify project"
      redirect_to projects_url # halts request cycle
    end
  end

  def verify_customer
    unless @project.is_customer(current_user) or @project.is_owner(current_user)
      flash[:error] = "You must be a member of this project to view it"
      redirect_to projects_url # halts request cycle
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params
    params.require(:project).permit(:name, :language, :phase_total, :phase_current, :description, :github_url, :github_secondary_url, :github_branch, :github_secondary_branch, :readme_file, :readme_remote, :stage_website_url, :demo_url, :prod_url, :complete, :stage_travis_api_url, :stage_travis_api_token, :prod_travis_api_token, :prod_travis_api_url, :coveralls_api_url,:customers_id)
  end
end
