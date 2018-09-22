class GitHubUser

  def initialize(owner)
    @owner = owner
  end

  def installed?
    @owner.github_connected?
  end

  def username
    @username ||= api.users.get
  end

  def repositories
    @repositories ||= api.repos.list
  end

  def user_repos_select
    @user_repos_select ||= user_repos.collect{ |r| [r.name, r.id]}
  end

  def api
    @api ||= Github.new oauth_token: @owner.oauth
  end

end
