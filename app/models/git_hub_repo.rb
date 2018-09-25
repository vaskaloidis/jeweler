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
    unless webhook_installed?
      @api.repos.hooks.create(username, repository_name, new_hook)
      @project.update(github_webhook_installed: true)
    end
  end

  def webhook_installed?
    @webhook_installed ||= begin
      return false unless available?
      webhooks.each do |hook|
        return true if our_webhook?(hook)
      end
      false
    end
  end

  def available?
    project_configured? && user_installed?
  end

  def project_configured?
    !@project.github_repo.nil?
  end

  def valid_repo?
    repository_ids.include? @project.github_repo
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
    (webhook.config.url == ENV['GITHUB_PUSH_HOOK']) && (webhook.config.content_type == 'json')
  end

  def new_webhook
    @new_webhook ||= {
        name: "web",
        active: true,
        config: {
            url: ENV['GITHUB_PUSH_HOOK'],
            content_type: "json"
        }
    }
  end

end
