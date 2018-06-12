# Interact with GitHub API using generated user Oauth
class GitHubOauth
  attr_accessor :github, :project

  def initialize(project)
    @project = project
    # @github = Github::Client::Repos::Hooks.new oauth_token: @project.owner.oauth
    @github = Github.new oauth_token: @project.owner.oauth
  end

  def gh_user
    uri = URI(project.github_url)
    uri.path.split('/').second
  end

  def gh_repo
    uri = URI(project.github_url)
    uri.path.split('/').third
  end

  def hooks
    github.repos.hooks.all gh_user, gh_repo
  end

  # Install our GitHub Push Webhook to the Project on GitHuB
  def install_webhook!
    unless webhook_installed?
      Rails.logger.debug 'GITHUB_HOOK_URL (ENV): ' + ENV['GITHUB_HOOK_URL']
      new_hook = {
          name: "web",
          active: true,
          config: {
              url: ENV['GITHUB_HOOK_URL'],
              content_type: "json"
          }
      }
      github.repos.hooks.create gh_user, gh_repo, new_hook
    end
  rescue => e
    # TODO: Get rid of this / make it catch more specific exceptions
    Rails.logger.error 'Github Hook Error: ' + e.message
    e.backtrace.each {|line| Rails.logger.error line}
  end

  # Check if the GitHub_URL for the project has a webhook installed,
  # the Webhook is checked by comapring the Hook URL in ENV to the
  # Projects Webhooks
  # TODO: Check how expensive this is, and if we need to do on each project#show
  def webhook_installed?
    if @project.github_installed?
      hooks.each do |hook|
        if hook.config.url == ENV['GITHUB_HOOK_URL'] && hook.config.content_type == 'json'
          return true
        end
      end
    end
    false
  rescue => e
    # TODO: Get rid of this / make it catch more specific exceptions
    Rails.logger.error 'Github Hook Error: ' + e.message
    e.backtrace.each {|line| Rails.logger.error line}
  end

end


