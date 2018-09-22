class GithubController < ApplicationController
  before_action :set_project, only: %i[install_webhook sync_commits]

  # protect_from_forgery with: :exception, if: Proc.new { |c| c.request.format != 'application/json' }
  # protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  # skip_before_action :verify_authenticity_token

  respond_to :json, :html

  def authorize_account
    github_api = GitHubApp.new
    user       = User.find(current_user.id)
    auth_url   = github_api.authorization_url

    respond_to do |format|
      if user.oauth.nil?
        format.html { redirect_to auth_url }
      else
        format.html { redirect_to root_path, notice: 'GitHub is already installed' }
      end
    end
  end

  def save_oauth
    authorization_code = params[:code]
    github_api         = GitHubApp.new
    access_token       = github_api.authorization_token(authorization_code)
    user               = User.find(current_user.id)
    user.update(oauth: access_token)

    # Eventually we want to do this here too
    #  but we don't have information about project_id here
    #  unless we pass it to GitHub first when we go to authorize
    #  the GitHub Account
    # gho = GitHubOauth.new(@project)
    # gho.install_webhook!

    respond_to do |format|
      if user.valid?
        format.html { redirect_to root_path, notice: 'GitHub Account Successfully Authenticated!' }
      else
        format.html { redirect_to root_path, :flash => { :error => 'Error Authenticated GitHub Authenticated.' } }
      end
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
    @project = Project.find(params[:project_id])
  end
end
