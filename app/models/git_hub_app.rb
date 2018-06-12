# Interact with GitHub API using Jeweler GH App Authentication
# which consists of client_id, and client_secret
class GitHubApp
  attr_accessor :github
  def self.build
    Github.new client_id: ENV['GITHUB_CLIENT_ID'], client_secret: ENV['GITHUB_CLIENT_SECRET']
  end

  def self.api
    build
  end

  def self.authorization_url
    github = build
    github.authorize_url scope: 'repo admin:repo_hook read:repo_hook write:repo_hook admin:org_hook'
  end

end