class GitHubWebhook
  attr_reader :parent

  def initialize(parent)
    @parent = parent
  end

  def install!
    return if installed? || !parent.configured?
    raise 'GITHUB_PUSH_HOOK Environment Variable Not Configured' if ENV['GITHUB_PUSH_HOOK'].nil?
    response = parent.api.repos.hooks.create(parent.username, parent.name, new_webhook)
    update_cache!(response[:id])
  end

  def installed?(cached: true)
    return false unless parent.configured?
    if cached
      return !id.nil?
    else
      if fetch_hook
        return true
      else
        return false
      end
    end
  end

  def uninstall!
    return unless installed?
    parent.api.repos.hooks.delete parent.username, parent.name, id
    parent.project.update!(github_webhook_id: nil)
  end

  protected

  def id
    @id ||= parent.project.github_webhook_id
  end

  def all
    @all ||= parent.api.repos.hooks.all(parent.username, parent.name)
  end

  def update_cache!(id_param = nil)
    if id_param.nil?
      error UPDATE_CACHE_WARNING
      ours = fetch_hook
      id_param = ours[:id] if fetch_hook
    end
    parent.project.update!(github_webhook_id: id_param)
  end

  # Caution: Un-Tested Yet
  def fetch_hook
    error UPDATE_CACHE_WARNING
    all.collect {|hook| return hook if ours?(hook)}
    false
  end

  def ours?(webhook)
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

  def error(msg)
    Rails.logger.error msg
  end

  UPDATE_CACHE_WARNING = 'WARNING: update_cache! and fetch_hook have not been tested. Fetching the webhook remotely once the local cached id has been lost, may have unexpected consequences.'.freeze
end