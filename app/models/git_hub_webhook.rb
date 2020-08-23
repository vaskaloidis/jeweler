class GitHubWebhook
  attr_reader :parent

  def initialize(parent)
    @parent = parent
    verify_env
  end

  def install!
    return if installed? || !parent.configured?
    response = parent.api.create_hook parent.name, new_webhook
    update_cache!(response[:id])
  end

  def installed?
    return false unless parent.configured?
    !id.nil?
  end

  def uninstall!
    return unless installed?
    parent.api.delete_hook parent.name, id
    parent.project.update!(github_webhook_id: nil)
  end

  protected

  def id
    @id ||= parent.project.github_webhook_id
  end

  def update_cache!(id_param)
    parent.project.update!(github_webhook_id: id_param)
  end

  def new_webhook
    app_url = ENV['APP_URL']
    full_hook_url = "#{app_url}/github/oauth/save"
    @new_webhook ||= {
        name: "web",
        active: true,
        config: {
            url: full_hook_url,
            content_type: "json"
        }
    }
  end

  def verify_env
    raise 'APP_URL Environment Variable Not Configured' if ENV['APP_URL'].nil?
  end

  def error(msg)
    Rails.logger.error msg
  end

end