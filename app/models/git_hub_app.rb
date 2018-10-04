# Interact with GitHub API using Jeweler GH App Authentication
# Env: client_id and client_secret
class GitHubApp
  # scopes: read:repo_hook write:repo_hook
  # Future scopes: write:discussion
  SCOPE = 'repo admin:repo_hook read:user'.freeze
  SCOPE2 = 'user, repo'.freeze

  def self.authorization_url
    api.authorize_url(scope: SCOPE)
  end

  def self.authorization_token(auth_code)
    api.get_token(auth_code).token
  end

  def self.review_url
    "https://github.com/settings/connections/applications/#{client_id}"
  end

  def self.valid_auth?(token)
    basic_auth_api.oauth.app.check client_id, token rescue false
  end

  def self.delete_auth!(token)
    return if !token.nil? || token != ''
    basic_auth_api.delete token
    basic_auth_api.oauth.app.delete client_id, token
  end

  protected

  def self.basic_auth_api
    Github.new basic_auth: "#{client_id}:#{client_secret}"
  end

  def self.api
    Github.new(client_id: client_id, client_secret: client_secret)
  end

  def self.client_secret
    ENV['GITHUB_CLIENT_SECRET']
  end

  def self.client_id
    ENV['GITHUB_CLIENT_ID']
  end

end