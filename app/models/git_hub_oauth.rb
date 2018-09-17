# Interact with GitHub API using generated user Oauth
class GitHubOauth
  attr_accessor :project

  def initialize(selected_project)
    @project = selected_project
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

  def install_webhook!
    github_api.repos.hooks.create(user, repo, new_hook)
  end

  def webhook_installed?
    @webhook_installed ||= begin
      return false unless project.github_installed?
      # TODO: Make this loop a one-liner later
      hooks.each do |hook|
        return true if our_hook?(hook)
      end
      false
    end
  end

  private

  def github_api
    @github_api ||= Github.new oauth_token: project.owner.oauth
  end

  def hooks
    @hooks ||= github_api.repos.hooks.all(user, repo)
  end

  def our_hook?(hook)
    hook.config.url == ENV['GITHUB_HOOK_URL'] && hook.config.content_type == 'json'
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


