# Interact with GitHub API using Jeweler GH App Authentication
# Env: client_id and client_secret
class GitHubApp

  def authorization_url
    @authorization_url ||= api.authorize_url scope: 'repo admin:repo_hook read:repo_hook write:repo_hook admin:org_hook'
  end

  def authorization_token(auth_code)
    @authorization_token ||= api.get_token(auth_code).token
  end

  private

  def api
    @api ||= Github.new client_id: ENV['GITHUB_CLIENT_ID'],
                        client_secret: ENV['GITHUB_CLIENT_SECRET']
  end

end