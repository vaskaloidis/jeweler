class GitHubApp

  attr_accessor :github, :gh_user, :gh_repo

  def initialize(project = nil)
    @project = project

    prepare project

    # logger.debug('GitHub User: ' + gh_user)
    # logger.debug('GitHub Repo: ' + gh_repo)
  end

  def prepare project
    @github = Github.new client_id: ENV['GITHUB_CLIENT_ID'], client_secret: ENV['GITHUB_CLIENT_SECRET']
    # @github = Github.new oauth: @project.owner.oauth
    # @github = Github.new basic_auth: 'vaskaloidis:' + ENV['GITHUB_PASSWORD']
    return @github
  end

  def gh_user
    uri = URI(@project.github_url)
    return @gh_user = uri.path.split('/').second
  end

  def gh_repo
    uri = URI(@project.github_url)
    @gh_repo = uri.path.split('/').third
    return @gh_repo
  end

  def self.gh_user(project)
    uri = URI(project.github_url)
    return gh_user = uri.path.split('/').second
  end

  def self.gh_repo(project)
    uri = URI(project.github_url)
    gh_repo = uri.path.split('/').third
    return gh_repo
  end

  def self.authorization_url(project)
    initialize project
    # return authorization_url
  end

  def authorization_url
    @github.authorize_url scope: 'repo admin:repo_hook write:repo_hook read:repo_hook admin:org_hook notifications'
    return @github.authorize_url
  end

  def self.github_hook_configured?(project)
    begin
      hooks = @github.repos.hooks.all gh_user(project), gh_repo(project)
      hooks.each do |hook|
        if hook.config.url == ENV['GITHUB_HOOK_URL'] and hook.config.content_type == 'json'
          return true
        end
      end
      return false
    rescue => e
      Rails.logger.error 'Github Hook Error: ' + e.message
      e.backtrace.each {|line| Rails.logger.error line}
    end
  end

  def github_hook_configured?
    return self.github_hook_configured? @project
  end

  def install_github_webhook
    begin
      unless github_hook_configured?
        Rails.logger.debug 'GITHUB_HOOK_URL (ENV): ' + ENV['GITHUB_HOOK_URL']
        new_hook = {
            name: "web",
            active: true,
            config: {
                url: ENV['GITHUB_HOOK_URL'],
                content_type: "json"
            }
        }
        @github.repos.hooks.create @gh_user, @gh_repo, new_hook
      end
    rescue => e
      Rails.logger.error 'Github Hook Error: ' + e.message
      e.backtrace.each {|line| Rails.logger.error line}
    end
  end

end