# require 'Github/Error'

class GitHubUser
  include ApplicationHelper
  include Github::Error

  def initialize(owner)
    @owner = owner
  end

  def user_configured?
    !@owner.github_oauth.nil? && (@owner.github_oauth != '')
  end

  def username
    @username ||= api.username
  end

  def avatar
    @avatar ||= api.avatar
  end

  def repositories
    @repositories ||= begin
      api.repos
    rescue Github::Error::GithubError => error
      log_error(error)
      return false
    end
  end

  def valid?
    return true if repositories
    false
  end

  def install_webhooks!
    @owner.owner_projects.each do |project|
      project.github.webhook.install!
    end
  end

  def install!(token)
    @owner.update!(github_oauth: token)
  end

  def uninstall!
    @owner.owner_projects.each do |project|
      project.github.uninstall!
    end
    GitHubApp.delete_auth!(token)
    @owner.update!(github_oauth: nil)
  end

  def api
    auth_valid?
    GitHubOauth.new(token)
  end

  def log_error(error)
    if error.is_a? Github::Error::Unauthorized
      Rails.logger.error "Oauth Token Expired: #{error.inspect}"
      redirect_to project_settings_path, error: unauthorized_error
    else
      Rails.logger.error "GitHub Error: #{error.inspect}"
      redirect_to project_settings_path, error: general_error
    end
  end

  def auth_valid?
    @auth_valid ||= begin
      unless GitHubApp.valid_auth?(token)
        current_user.update!(github_oauth: nil)
        log_error('GitHub Invalid Auth Token!')
        raise GitHub::Error::Unauthorized('Invalid Auth Token')
      end
      true
    end
  end

  protected

  def token
    @owner.github_oauth
  end

  def unauthorized_error
    contact_support('There was a problem with the GitHub Authentication. You must re-authenticate GitHub.')
  end

  def general_error
    contact_support('There was a problem with the GitHub Connection.')
  end

end
