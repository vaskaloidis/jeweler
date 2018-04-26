class ProjectsController < ApplicationController
  before_action :set_project, only: [:verify_owner, :show, :edit, :update, :destroy]
  before_action :verify_invoices_exist, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :verify_owner, only: [:edit, :update, :destroy]
  respond_to :html, :js, only: [:request_payment]

  def commit_codes_modal

    respond_to do |format|
      format.js
    end
  end

  def request_payment
    @invoice = Invoice.find(params[:invoice_id])
    if @invoice.cost > 0
      @invoice.payment_due = true
      @invoice.save

      @user = current_user

      @project = @invoice.project

      if @invoice.valid?
        Note.create_payment_request(@invoice, current_user)
      end
    end


    respond_to do |format|
      format.js
    end
  end

  def cancel_request_payment
    @invoice = Invoice.find(params[:invoice_id])
    @invoice.payment_due = false
    @invoice.save

    @user = current_user

    Note.create_event(@invoice.project, 'payment_request_cancelled', 'Sprint ' + @invoice.sprint.to_s + ' Payment Request Canceled')

    respond_to do |format|
      format.js
    end
  end

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

    begin
      readme_raw = Net::HTTP.get(URI.parse(gh_url))

      if readme_raw == 'Not Found'
        @github_readme_parsed = 'README file could not be loaded.<br>
                               GitHub README file: ' + gh_url
      else
        redcarpet = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
        @github_readme_parsed = redcarpet.render(readme_raw)
      end

    rescue => ex
      logger.error ex.message
      @github_readme_parsed = 'README file could not be loaded.<br>
                               GitHub README file: ' + gh_url
    end

    @notes = @project.notes.where(note_type: [:note, :commit, :project_update]).order('created_at DESC').all
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
    @project.owner = current_user

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
    unless @project.is_owner?(current_user)
      flash[:error] = "You must be the owner to modify project"
      redirect_to projects_url # halts request cycle
    end
  end

  def verify_customer
    unless @project.is_customer(current_user) or @project.is_owner?(current_user)
      flash[:error] = "You must be a member of this project to view it"
      redirect_to projects_url # halts request cycle
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end


  def sync_github(project, user)
    unless project.owner.oauth.nil?
      if project.is_owner?(user)
        begin
        github = Github.new oauth: project.owner.oauth
        logger.debug('GitHub User: ' + ApplicationHelper.github_user(project))
        logger.debug('GitHub Repo: ' + ApplicationHelper.github_repo(project))
        repos = github.repos.commits.all ApplicationHelper.github_user(project), ApplicationHelper.github_repo(project)
        repos.each do |commit|
          sha = commit.sha
          if Note.where(project: project, git_commit_id: sha).empty?
            note = Note.new
            note.author = project.owner
            note.note_type = 'commit'
            note.git_commit_id = sha
            note.sync = true
            note.project = project
            note.content = commit.commit.message.to_s + ' - ' + commit.commit.author.name.to_s

            unless project.current_sprint.nil?
              note.invoice = project.current_sprint
            end
            unless project.current_task.nil?
              note.invoice_item = project.current_task
            end

            note.created_at = commit.commit.committer.date
            note.save
            puts 'Note Created for Commit Sync, SHA: ' + commit.sha
          end
        end
        rescue Exception
          logger.error("Error syncing Github Repo")
          logger.error
        end
      end
    end
  end

  def verify_invoices_exist
    # Require Each Sprint_Total Invoice Exists
    total_sprint_count = @project.sprint_total + 1
    total_sprint_count.times do |sprint|
      if @project.get_sprint(sprint).nil? and sprint != 0
        invoice = Invoice.new
        invoice.project = @project
        invoice.sprint = sprint

        if @project.sprint_current == sprint
          invoice.open = true
        else
          invoice.open = false
        end

        invoice.save
      end
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params
    params.require(:project).permit(:name, :language, :image, :sprint_total, :sprint_current, :description, :github_url, :heroku_token, :github_branch, :github_secondary_branch, :readme_file, :readme_remote, :stage_website_url, :demo_url, :prod_url, :complete, :stage_travis_api_url, :stage_travis_api_token, :prod_travis_api_token, :prod_travis_api_url, :coveralls_api_url, :customers_id, :invoice_item_id)
  end
end
