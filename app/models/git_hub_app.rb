# Interact with GitHub API using Jeweler GH App Authentication
# Env: client_id and client_secret
class GitHubApp
  delegate :url_helpers, to: 'Rails.application.routes'

  def initialize
    @client_id = ENV['GITHUB_CLIENT_ID']
    @client_secret = ENV['GITHUB_CLIENT_SECRET']
  end

  def authorization_url(project = nil)
    scope = 'repo admin:repo_hook read:repo_hook write:repo_hook admin:org_hook'
    @authorization_url ||= begin
      if project.nil?
        api.authorize_url(scope: scope, redirect_url: url_helpers.github_oauth_save_path)
      else
        api.authorize_url(scope: scope, redirect_url: url_helpers.github_oauth_save_path(project))
      end
    end
  end

  def authorization_token(auth_code)
    api.get_token(auth_code).token
  end

  private

  def api
    @api ||= Github.new client_id: client_id,
                        client_secret: client_secret
  end

  attr_reader :client_id, :client_secret

end