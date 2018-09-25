class GitHubUser

  def initialize(owner)
    @owner = owner
    api
  end

  def user_installed?
    @owner.github_connected?
  end

  def username
    @username ||= api.users.get
  end

  def repositories
    @repositories ||= api.repos.list
  end

  protected

  def api
    @api ||= begin
      Github.new oauth_token: @owner.oauth
    end
  end

end
