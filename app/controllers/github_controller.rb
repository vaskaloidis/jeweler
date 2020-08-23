class GithubController < ApplicationController
  before_action :set_project, only: %i[install_webhook uninstall_webhook sync_commits]
  respond_to :json, :html

  def authorize_account
    redirect_to GitHubApp.authorization_url
  end

  def delete_oauth
    user = User.find(current_user.id)
    user.github.uninstall!
    redirect_to edit_user_registration_path, notice: 'GitHub Disconnected. Webhooks Uninstalled.'
  end

  def save_oauth
    authorization_code = params[:code]
    token = GitHubApp.authorization_token(authorization_code)
    install_successful = current_user.github.install!(token)
    if install_successful
      redirect_to root_path, notice: 'GitHub Successfully Authenticated. Webhooks installed.'
    else
      redirect_to root_path, error: contact_support('Error Saving GitHub Oauth Token.')
    end
  end

  def install_webhook
    @project.github.webhook.install!
  end

  def uninstall_webhook
    @project.github.webhook.uninstall!
  end

  def push_hook
    @service = PushWebhook.call(@project)
    @errors = @service.errors
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
