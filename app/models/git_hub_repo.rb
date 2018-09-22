class GitHubRepo < GitHubUser

  def initialize(project)
    @project = project
    super(@project.owner)
  end

  def github_url
    return false unless installed?
    "https://github.com/#{user}/#{repo}"
  end

  def repo
    @repo ||= github_repo(@project.github_repo).name
  end

  def install_webhook!
    api.repos.hooks.create(user, repo, new_hook)
  end

  def webhook_installed?
    @webhook_installed ||= begin
      return false unless installed? && !repo.nil?
      hooks.each do |hook|
        return true if our_hook?(hook)
      end
      false
    end
  rescue Github::Error::NotFound
    logger.error 'Invalid GitHub Repo in webhook_installed?'
    false
  end

  private

  def github_repo(id)
    @github_repo ||= api.repos.get_by_id(id)
  end

  def hooks
    @hooks ||= api.repos.hooks.all(user, repo)
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
