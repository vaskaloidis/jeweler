# Interact with GitHub API using generated user Oauth
class GitHubOauth
  attr_accessor :project

  def initialize(selected_project)
    @project ||= selected_project
  end

  def github_api
    @github_api ||= Github.new oauth_token: @project.owner.oauth
  end

  def user
    @user ||= begin
      uri = URI(project.github_url)
      uri.path.split('/').second
    end
  end

  def repo
    @repo ||= begin
      uri = URI(project.github_url)
      uri.path.split('/').third
    end
  end

  def hooks
    @hooks ||= github_api.repos.hooks.all user, repo
  end

  def install_webhook!
    github_api.repos.hooks.create user, repo, new_hook unless webhook_installed
  rescue => e # TODO: Make it catch more specific exceptions
    Rails.logger.fatal 'Github Hook Error: ' + e.message
  end

  def webhook_installed
    # TODO: Cache this somehow
    @webhook_installed ||= begin
      false if project.github_installed?
      hooks.each do |hook|
        return true if hook.config.url == ENV['GITHUB_HOOK_URL'] && hook.config.content_type == 'json'
      end
      false
    rescue => e # TODO: Make it catch more specific exceptions
      Rails.logger.fatal 'Github Hook Error: ' + e.message
      false
    end
  end

  def new_hook
    @new_hook ||= {
        name: "web",
        active: true,
        config: {
            url: ENV['GITHUB_HOOK_URL'],
            content_type: "json"
        }
    }
  end

end


