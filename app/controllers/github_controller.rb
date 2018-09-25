class GithubController < ApplicationController
  before_action :set_project, only: %i[install_webhook sync_commits authorize_account save_oauth]

  # protect_from_forgery with: :exception, if: Proc.new { |c| c.request.format != 'application/json' }
  # protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  # skip_before_action :verify_authenticity_token

  respond_to :json, :html

  def authorize_account
    github_api = GitHubApp.new
    auth_url = github_api.authorization_url(@project)
    redirect_to auth_url
  end

  def delete_oauth
    user = User.find(current_user.id)
    user.update!(oauth: nil)
    user.owner_projects.each do |p|
      p.update!(github_repo: nil, github_webhook_installed_cache: false)
    end
    redirect_to root_path, notice: 'GitHub Disconnected.'
  end

  def save_oauth
    authorization_code = params[:code]
    api = GitHubApp.new
    access_token = api.authorization_token(authorization_code)
    result = current_user.update!(oauth: access_token)
    if result
      project.github.install_webhook!
      redirect_to root_path, notice: 'GitHub Successfully Authenticated!'
    else
      redirect_to root_path, :flash => {:error => contact_support('Error Saving GitHub Oauth Token.')}
    end
  end

  def install_webhook
    GitHubRepo.new(@project).install_webhook!
  end

  # GitHub WebHook Push Event endpoint
  def hook
    @service = PushWebhook.call(@project)
    @errors = service.errors
  end

  def sync_commits
    @service = SyncGithubCommits.call(@project, current_user)
    @errors = @service.errors
  end

  private

  def set_project
    @project = params[:project_id].nil? ? nil : Project.find(params[:project_id])
  end
end
