# Interact with GitHub API using Jeweler GH App Authentication
# Env: client_id and client_secret
class GitHubApp

  def initialize
    github_api
  end

  def self.github_api
    @github_api ||= Github.new client_id: ENV['GITHUB_CLIENT_ID'],
                        client_secret: ENV['GITHUB_CLIENT_SECRET']
  end

  def self.authorization_url
    @authorization_url ||= github_api.authorize_url scope: 'repo admin:repo_hook read:repo_hook write:repo_hook admin:org_hook'
  end

  def self.authorization_token(auth_code)
    @authorization_token ||= github_api.get_token(auth_code)
  end

end