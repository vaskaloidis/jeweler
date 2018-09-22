class GitHubRepo < GitHubUser

  def initialize(project)
    @project = project
    super(@project.owner)
  end

  def url
    return false unless available?
    "https://github.com/#{username}/#{repository_name}"
  end

  def repository_name
    @repository_name ||= repository.name
  end

  def install_webhook!
    @api.repos.hooks.create(user, repo, new_hook)
  end

  def webhook_installed?
    begin
      @webhook_installed ||= begin
        return false unless available?
        webhooks.each do |hook|
          return true if our_webhook?(hook)
        end
        false
      end
    rescue Github::Error::NotFound
      Rails.logger.error 'Invalid GitHub Repo in webhook_installed?'
      return false
    end
  end

  def available?
    repo_configured? && installed?
  end

  def repo_configured?
    !@project.github_repo.nil?
  end

  def repo_valid?(id = nil)
    id = @project.github_repo if id.nil?
    repository_ids.include? id
  end

  private

  def repository_ids
    @repository_ids ||= repositories.collect {|r| r.id}
  end

  def repository_id
    @repository_id ||= @project.github_repo
  end

  def repository
    @repository ||= api.repos.get_by_id(repository_id)
  end

  def webhooks
    @webhooks ||= api.repos.hooks.all(username, repository_name)
  end

  def our_webhook?(webhook)
    (webhook.config.url == ENV['GITHUB_HOOK_URL']) && (webhook.config.content_type == 'json')
  end

  def new_webhook
    @new_webhook ||= {
        name: "web",
        active: true,
        config: {
            url: ENV['GITHUB_HOOK_URL'],
            content_type: "json"
        }
    }
  end

end
