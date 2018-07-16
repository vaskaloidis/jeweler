# Interact with GitHub API using Jeweler GH App Authentication
# Env: client_id and client_secret
class GitHubApp
  include Singleton

  # class << self
  #   delegate :authorization_url, to: :instance
  #   delegate :authorization_token, to: :instance
  # end

  def self.api
    @api ||= Github.new client_id: ENV['GITHUB_CLIENT_ID'],
                        client_secret: ENV['GITHUB_CLIENT_SECRET']
  end

  def self.authorization_url
    @authorization_url ||= api.authorize_url scope: 'repo admin:repo_hook read:repo_hook write:repo_hook admin:org_hook'
  end

  def self.authorization_token(auth_code)
    @authorization_token ||= api.get_token(auth_code)
  end

  private

end